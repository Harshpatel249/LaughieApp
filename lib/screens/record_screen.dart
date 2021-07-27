import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laughie_app/rewidgets/show_toast.dart';
import 'package:laughie_app/screens/assess_video.dart';
import 'package:laughie_app/screens/laughieFeedback.dart';
import 'package:laughie_app/screens/sessionFeedback.dart';
import 'package:laughie_app/screens/test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

typedef _Fn = void Function();

class RecordScreen extends StatefulWidget {
  static String id = 'record_screen';

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  File savedFile;
  File fileMedia;
  bool isRecorded = false;

  final _audioPlayerDuration = 4.00;
  final _audioRecordDuration = 4.00;

  bool recordLaughieStatus;
  String _filePath;
  String _mediaType;
  bool _isFetched = false;

  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  String _mPath;

  bool _hasTimeCompleted = false;
  bool _isRecordingSelected = false;
  bool _isSaveClicked = false;

  Timer _timer = Timer(Duration.zero, () {});
  double progressValue = 0;

  _getAudioSaveLocation() async {
    Directory directory;
    directory = await getExternalStorageDirectory();
    print(
        "--------------------------------------------------------------${directory.path}");
    String audioFileLoc = directory.path + "/recorded_session.mp3";
    this._mPath = audioFileLoc;
  }

  //----------------------Functions for audio recorder
  @override
  void initState() {
    // _getRecordLaghieStatus();
    _getAudioSaveLocation();
    _mPlayer.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _mPlayer.closeAudioSession();
    _mPlayer = null;

    _mRecorder.closeAudioSession();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openAudioSession();
    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    print('%%%%%%%%%%%%%%%%%%%%%%% inside record %%%%%%%%%%%%%%%%%%%');
    _mRecorder
        .startRecorder(
      toFile: _mPath,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    )
        .then((value) {
      setState(() {});
    });
    print(_mPath);
  }

  void stopRecorder() async {
    print('##### stopRecorder');
    await _mRecorder.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    print('%%%%%%%%%%%%%%%%%%%%%%% inside play %%%%%%%%%%%%%%%%%%%');

    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder.isStopped &&
        _mPlayer.isStopped);
    _mPlayer
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
    // usersRef.doc(FirebaseAuth.instance.currentUser.uid).update({
    //   "has_recorded_laughie": true,
    //   "media": "audio",
    //   "filePath": _mPath,
    // });
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn startRecordCounter() {
    progressValue = 0;

    print('########### inside startCounter');
    if (!_mRecorderIsInited || !_mPlayer.isStopped) {
      print('inside !_mRecorderIsInited || !_mPlayer!.isStopped');
      return null;
    }
    if (_timer != null) {
      print('inside _timer != null');
      _timer.cancel();

      stopRecorder();
    }
    print('${DateTime.now()}');
    record();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer _timer) {
        print('inside anonymous function');
        setState(() {
          print('${DateTime.now()}');
          print('$progressValue');
          progressValue++;
          if (progressValue > _audioRecordDuration) {
            print('#### inside if');
            setState(() {
              _hasTimeCompleted = true;
            });
            _timer.cancel();
            stopRecorder();
          }
        });
      },
    );
  }

  _Fn startPlayerCounter() {
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
          if (progressValue > _audioPlayerDuration) {
            print('#### inside if');

            _timer.cancel();
            stopPlayer();
          } else {
            print('#### inside else');

            // play();
          }
        });
      },
    );
  }

  _Fn getRecorderFn() {
    print('###### inside getRecorderFn');
    if (!_mRecorderIsInited || !_mPlayer.isStopped) {
      return null;
    }
    print('here');
    // startCounter();
    return _mRecorder.isStopped ? record : stopRecorder;
  }

  _Fn getPlaybackFn() {
    print('###### inside getPlaybackFn');
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
      return null;
    }

    return _mPlayer.isStopped ? play : stopPlayer;
  }

  IconData getIcon() {
    return _isSaveClicked
        ? Icons.done
        : _hasTimeCompleted
            ? _mPlayer.isPlaying
                ? Icons.stop
                : Icons.play_arrow
            : _mRecorder.isRecording
                ? Icons.stop
                : Icons.mic;
  }

  _onAudioButtonPressed() {
    if (!_isSaveClicked) {
      setState(() {
        _isRecordingSelected = true;
      });
      print('@@@@_mRecorder!.isRecording:${_mRecorder.isRecording}');
      print('@@@@_hasTimeCompleted:${_hasTimeCompleted}');
      if (_mRecorder.isRecording == false && _hasTimeCompleted == false) {
        print('@@@@inside if1');
        startRecordCounter();
      } else if (_mRecorder.isRecording == true && _hasTimeCompleted == false) {
        print('@@@@inside if2');
        _timer.cancel();
        setState(() {
          progressValue = 0;
        });
        stopRecorder();
      } else if (_mRecorder.isStopped == true &&
          _hasTimeCompleted == true &&
          _mPlayer.isStopped == true) {
        print('@@@@inside if3');
        startPlayerCounter();
        play();
      } else if (_mRecorder.isStopped == true &&
          _hasTimeCompleted == true &&
          _mPlayer.isStopped == false) {
        print('@@@@inside if4');
        _timer.cancel();
        setState(() {
          progressValue = 0;
        });
        stopPlayer();
      }
    }
  }

  //---------------Functions for video recorder-------------------------------

  Future<File> pickCameraMedia(BuildContext context) async {
    // bool saved = await saveFile('recording.mp4');
    // ModalRoute is used to retrieve the info that has been passed down using Navigator
    //final MediaSource source = ModalRoute.of(context).settings.arguments;
    // ImagePicker is the plugin that we've integrated.
    // source is used to determine whether to select getImage or getVideo
    print('Here');
    final getMedia = ImagePicker().getVideo;
    // Since this widget is for picking images from gallery
    final media = await getMedia(source: ImageSource.camera);

    final file = File(media.path);
    print("###################################################${media.path}");
    return file;
    // Navigator.of(context).pop(file);
  }

  Future capture(BuildContext context) async {
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!! capture called !!!!!!!!!!!!!!!!!!!');
    String fileName = 'recorded_laughie.mp4';
    //
    // if (fileMedia != null) {
    //   setState(() {
    //     this.fileMedia = null;
    //   });
    // }
    // source is passed down to SourcePage() using a property called 'settings';
    // The info wrapped inside RouteSettings will then be received on the other side
    // final result = await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => SourcePage(),
    //     settings: RouteSettings(
    //       arguments: source,
    //     ),
    //   ),
    // );
    final recordedVideo = await pickCameraMedia(context);

    if (recordedVideo == null) {
      return;
    } else {
      // final _saveResult = await ImageGallerySaver.saveFile(recordedVideo.path);
      //
      // print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${_saveResult['filePath']}');
      // usersRef.doc(FirebaseAuth.instance.currentUser.uid).update({
      //   "has_recorded_laughie": true,
      //   "media": "video",
      //   "filePath": _saveResult['filePath'],
      // });

      setState(() {
        fileMedia = recordedVideo;
        isRecorded = true;

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => LaughieFeedback(),
        //     ),
        //     (route) => false);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AssessVideo(
                recordedVideo: recordedVideo,
              ),
            ),
            (route) => false);
      });
    }
  }

  checkPermission(BuildContext context) async {
    var cameraStatus = await Permission.camera.status;
    var micStatus = await Permission.microphone.status;
    var wrtStatus = await Permission.storage.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    if (!micStatus.isGranted) {
      await Permission.microphone.request();
    }
    if (!wrtStatus.isGranted) {
      await Permission.storage.request();
    }
    if (await Permission.camera.isGranted) {
      if (await Permission.microphone.isGranted) {
        if (await Permission.storage.isGranted) {
          capture(context);
        } else {
          print('storage permission required');
        }
      } else {
        print('mic permission required');
      }
    } else {
      print('cam permission required');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final AlertDialog warningDialog = AlertDialog(
      title: Text(
        'Warning',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Video of the recorded Laughie should not be longer than 1 minute otherwise you will be required to record the video again.',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            checkPermission(context);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    final appBar = AppBar(
      centerTitle: true,
      title: Text('Record'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.help,
            size: 30,
          ),
          onPressed: () => null,
        ),
      ],
    );
    final appBarHeight = appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            // color: Colors.red,
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.5,
            width: (mediaQuery.size.height -
                    appBar.preferredSize.height -
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
          ),
          _isRecordingSelected
              ? _hasTimeCompleted
                  ? Container(
                      color: Colors.blue,
                      height: (mediaQuery.size.height -
                              appBarHeight -
                              mediaQuery.padding.top) *
                          0.5,
                      width: (mediaQuery.size.height -
                              appBarHeight -
                              mediaQuery.padding.top) *
                          0.5,
                      child: LayoutBuilder(builder: (ctx, constraints) {
                        return _isSaveClicked
                            ? Container(
                                // color: Colors.amber,
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 40),
                                  height: constraints.maxHeight * 0.22,
                                  width: constraints.maxWidth * 0.4,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Theme.of(context).primaryColor),
                                    onPressed: () {
                                      setState(() {
                                        _isSaveClicked = true;
                                      });

                                      usersRef
                                          .doc(FirebaseAuth
                                              .instance.currentUser.uid)
                                          .update({
                                        "has_recorded_laughie": true,
                                        "media": "audio",
                                        "filePath": _mPath,
                                      });

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LaughieFeedback(),
                                          ),
                                          (route) => false);
                                    },
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'Player Functionality Activated.',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            bottom: 40, left: 20),
                                        height: constraints.maxHeight * 0.22,
                                        width: constraints.maxWidth * 0.4,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Theme.of(context)
                                                  .primaryColor),
                                          onPressed: () {
                                            setState(() {
                                              _hasTimeCompleted = false;
                                              progressValue = 0;
                                              stopPlayer();
                                              _timer.cancel();
                                            });
                                          },
                                          child: Text(
                                            'Retake',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.only(
                                            bottom: 40, right: 20),
                                        height: constraints.maxHeight * 0.22,
                                        width: constraints.maxWidth * 0.4,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Theme.of(context)
                                                  .primaryColor),
                                          onPressed: () {
                                            ShowToast.showToast(
                                                'Laughie has been saved');
                                            setState(() {
                                              _isSaveClicked = true;
                                              stopPlayer();
                                              _timer.cancel();
                                              progressValue =
                                                  _audioPlayerDuration;
                                            });
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                      }),
                    )
                  : Center(
                      child: Text(
                        'Recorder Functionality Activated.',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
              : Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.5,
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(shape: CircleBorder()),
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
                                Icons.videocam,
                                size: constraints.maxHeight * 0.475 * 0.5,
                                color: Color(0xfffbb313),
                              ),
                            ),
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => warningDialog,
                              );
                            },
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.07,
                          ),
                          Container(
                            height: constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                'Record Video',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
