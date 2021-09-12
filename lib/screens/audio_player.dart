import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'laughieFeedback.dart';

typedef _Fn = void Function();

class AudioPlayer extends StatefulWidget {
  double appBarheight;
  String audioFileSrc;
  AudioPlayer(this.appBarheight, this.audioFileSrc);
  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

// Implemented from the example in the documentation of flutter_sound
class _AudioPlayerState extends State<AudioPlayer> {
  double progressValue = 0;

  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mplaybackReady = false;

  final _audioPlayerDuration = 4.00;

  Timer _timer = Timer(Duration.zero, () {});

  @override
  void initState() {
    _mplaybackReady = true;
    _mPlayer.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _mPlayer.closeAudioSession();
    _mPlayer = null;
    super.dispose();
  }

  void play() {
    assert(_mPlayerIsInited && _mplaybackReady && _mPlayer.isStopped);
    _mPlayer
        .startPlayer(
            fromURI: widget.audioFileSrc,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

  //starts the countdown of 1 minute.
  _Fn startCounter() {
    progressValue = 0;

    if (!_mPlayer.isStopped) {
      return null;
    }
    if (_timer != null) {
      _timer.cancel();

      stopPlayer();
    }
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer _timer) {
        setState(() {
          progressValue++;
          if (progressValue > _audioPlayerDuration) {
            _timer.cancel();
            stopPlayer();
          } else {
            // play();
          }
        });
      },
    );
  }

  _onAudioButtonPressed() {
    if (_mPlayer.isStopped == true) {
      startCounter();
      play();
    } else {
      _timer.cancel();
      setState(() {
        progressValue = 0;
      });
      stopPlayer();
    }
  }

  IconData getIcon() {
    return _mPlayer.isPlaying ? Icons.stop : Icons.play_arrow;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.size.width * 0.05;
    return Column(
      children: [
        Container(
          height: (mediaQuery.size.height -
                  widget.appBarheight -
                  mediaQuery.padding.top) *
              0.5,
          width: (mediaQuery.size.height -
                  widget.appBarheight -
                  mediaQuery.padding.top) *
              0.5,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: constraints.maxHeight * 0.57,
                        height: constraints.maxHeight * 0.57,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              showLabels: false,
                              showTicks: false,
                              startAngle: 270,
                              endAngle: 270,
                              radiusFactor: 1,
                              axisLineStyle: AxisLineStyle(
                                thickness: 0.1,
                                color: const Color.fromARGB(30, 0, 169, 181),
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                              pointers: <GaugePointer>[
                                RangePointer(
                                    value: progressValue * 1.6667,
                                    width: 0.1,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    enableAnimation: true,
                                    animationDuration: 100,
                                    animationType: AnimationType.linear)
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                        child: Container(
                          // width: 170,
                          // height: 170,
                          width: constraints.maxHeight * 0.475,
                          height: constraints.maxHeight * 0.475,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF222223),
                          ),
                          child: Icon(
                            getIcon(),
                            size: constraints.maxHeight * 0.475 * 0.5,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: _onAudioButtonPressed,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.07,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.1,
                    child: FittedBox(
                      child: Text(
                        _mRecorder.isRecording ? 'Stop' : 'Play',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LaughieFeedback()),
                    (route) => false);
              },
              child: Text(
                'End Session',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xfffbb313),
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // <-- Radius
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
            ),
          ),
        ),
      ],
    );
  }
}
