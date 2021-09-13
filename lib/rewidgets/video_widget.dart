import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

//To play a video on screen with play pause functionality
class VideoWidget extends StatefulWidget {
  final File file;
  final screenHeight;
  final url;

  const VideoWidget({this.file, this.screenHeight, this.url});

  @override
  VideoWidgetState createState() => VideoWidgetState();
}

class VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  Widget videoStatusAnimation;
  Icon controlIcon;
  @override
  void initState() {
    super.initState();

    videoStatusAnimation = Container();

    _controller = (widget.file == null && widget.url != null)
        ? VideoPlayerController.network(widget.url)
        : VideoPlayerController.file(widget.file)
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        Timer(Duration(milliseconds: 0), () {
          if (!mounted) return;

          setState(() {});
          _controller.pause();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _controller.value.isInitialized ? videoPlayer() : Container();

  Widget videoPlayer() => Column(
        children: [
          Expanded(
            child: Stack(
              children: <Widget>[
                video(),
                Center(
                  child: videoStatusAnimation,
                ),
              ],
            ),
          ),
          SizedBox(
            height: widget.screenHeight * 0.02,
          ),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            padding: EdgeInsets.only(left: 5, right: 5),
            colors: VideoProgressColors(
              backgroundColor: Color(0xff4D5163),
              playedColor: Color(0xffFBB313),
            ),
          ),
        ],
      );

  Widget video() => GestureDetector(
        child: VideoPlayer(_controller),
        onTap: () {
          if (!_controller.value.isInitialized) {
            Center(
              child: Icon(
                Icons.play_circle_outline,
                size: 100,
                color: Colors.white,
              ),
            );
            return;
          }
          if (_controller.value.isPlaying) {
            videoStatusAnimation = FadeAnimation(
              child: const Icon(
                Icons.pause_circle_outline,
                size: 100.0,
                color: Colors.white,
              ),
            );
            _controller.pause();
          } else {
            videoStatusAnimation = FadeAnimation(
              child: const Icon(
                Icons.play_circle_outline,
                size: 100.0,
                color: Colors.white,
              ),
            );
            _controller.play();
          }
        },
      );
}

class FadeAnimation extends StatefulWidget {
  const FadeAnimation(
      {this.child, this.duration = const Duration(milliseconds: 1000)});

  final Widget child;
  final Duration duration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => animationController.isAnimating
      ? Opacity(
          opacity: 1.0 - animationController.value,
          child: widget.child,
        )
      : Container();
}
