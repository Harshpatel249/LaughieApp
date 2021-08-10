import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/record_screen.dart';
import 'package:laughie_app/screens/test.dart';
import 'package:video_player/video_player.dart';

import 'laughieFeedback.dart';

class AssessVideo extends StatefulWidget {
  // const AssessVideo({Key? key}) : super(key: key);
  final File recordedVideo;

  AssessVideo({this.recordedVideo});
  @override
  _AssessVideoState createState() => _AssessVideoState();
}

class _AssessVideoState extends State<AssessVideo> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  int allowedVideoLength = 11;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.recordedVideo);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _saveVideo() async {
    final _saveResult =
        await ImageGallerySaver.saveFile(widget.recordedVideo.path);

    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${_saveResult['filePath']}');
    usersRef.doc(FirebaseAuth.instance.currentUser.uid).update({
      "has_recorded_laughie": true,
      "media": "video",
      "filePath": _saveResult['filePath'],
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LaughieFeedback(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // AlertDialog warning = ;
    print('##################### build called');
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(
                "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ duration: ${_controller.value.duration.inSeconds} s @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            // return AspectRatio(
            //   aspectRatio: _controller.value.aspectRatio,
            //   // Use the VideoPlayer widget to display the video.
            //   child: VideoPlayer(_controller),
            // );

            if (_controller.value.duration.inSeconds > allowedVideoLength) {
              print(
                  '###################################### video is too long @################');

              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff717171), Color(0xff717171)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: AlertDialog(
                  title: Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    'Recording duration is greater than 1 minute. Please record again',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('RETRY'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordScreen(),
                          ),
                        );
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecordScreen(),
                            ),
                            (route) => false);
                        // Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            } else {
              print(
                  '###################################### video is not so long @################');
              _saveVideo();
            }

            return Container();
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(
              child: CircularProgressBar(),
            );
          }
        },
      ),
    );
  }
}
