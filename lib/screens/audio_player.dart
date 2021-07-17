import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_sound/flutter_sound.dart';

typedef _Fn = void Function();

class AudioPlayer extends StatefulWidget {
  double appBarheight;
  String audioFileSrc;
  AudioPlayer(this.appBarheight, this.audioFileSrc);
  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  double progressValue = 0;

  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mplaybackReady = false;

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
    print('%%%%%%%%%%%%%%%%%%%%%%% inside play %%%%%%%%%%%%%%%%%%%');
    print('### path inside play: ${widget.audioFileSrc}');
    print('_mPlayerIsInited: $_mPlayerIsInited');
    print('_mplaybackReady: $_mplaybackReady');
    print('_mPlayer.isStopped: ${_mPlayer.isStopped}');
    assert(_mPlayerIsInited && _mplaybackReady && _mPlayer.isStopped);
    _mPlayer
        .startPlayer(
            fromURI: widget.audioFileSrc,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              print('inside whenFinished');
              setState(() {});
            })
        .then((value) {
      print('inside then play');
      setState(() {});
    });
    print('after player');
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

  _Fn startCounter() {
    progressValue = 0;

    print('########### inside startCounter');
    if (!_mPlayer.isStopped) {
      print('inside !_mRecorderIsInited || !_mPlayer.isStopped');
      return null;
    }
    if (_timer != null) {
      print('inside _timer != null');
      _timer.cancel();

      stopPlayer();
    }
    print('${DateTime.now()}');
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer _timer) {
        print('inside anonymous function');
        setState(() {
          print('${DateTime.now()}');
          print('$progressValue');
          progressValue++;
          if (progressValue > 5.00) {
            print('#### inside if');

            _timer.cancel();
            stopPlayer();
          } else {
            print('#### inside else');

            play();
          }
        });
      },
    );
  }

  _onAudioButtonPressed() {
    if (_mPlayer.isStopped == true) {
      print('@@@@inside if3');
      startCounter();
      play();
    } else {
      print('@@@@inside if4');
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
    return Container(
      // color: Colors.red,
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
                    // color: Colors.amber,
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
                      // primary: Colors.orange,
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
                    _mRecorder.isRecording
                        ? 'Recording in progress'
                        : 'Record Audio',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
