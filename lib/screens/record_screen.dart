import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'videoRecorder.dart';

typedef _Fn = void Function();

class RecordScreen extends StatefulWidget {
  static String id = 'record_screen';

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  File fileMedia;
  bool isRecorded = false;

  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  final String _mPath = 'flutter_sound_example.aac';

  bool _hasTimeCompleted = false;
  bool _isRecordingSelected = false;

  Timer _timer = Timer(Duration.zero, () {});
  double progressValue = 0;

  //----------------------Functions for audio recorder
  @override
  void initState() {
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
    _mRecorder
        .startRecorder(
      toFile: _mPath,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    )
        .then((value) {
      setState(() {});
    });
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
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn startCounter() {
    progressValue = 0;

    print('########### inside startCounter');
    if (!_mRecorderIsInited || !_mPlayer.isStopped) {
      print('inside !_mRecorderIsInited || !_mPlayer.isStopped');
      return null;
    }
    if (_timer != null) {
      print('inside _timer != null');
      _timer.cancel();

      stopRecorder();
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
          if (progressValue > 59.00) {
            print('#### inside if');
            setState(() {
              _hasTimeCompleted = true;
            });
            _timer.cancel();
            stopRecorder();
          } else {
            print('#### inside else');
            record();
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
    return _hasTimeCompleted
        ? _mPlayer.isPlaying
            ? Icons.stop
            : Icons.play_arrow
        : _mRecorder.isRecording
            ? Icons.stop
            : Icons.mic;
  }

  //---------------Functions for video recorder-----------
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

  Future uploadVideoToFirebase(BuildContext context, File fileMedia) async {
    // String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'recorded_sessions/${FirebaseAuth.instance.currentUser.uid}/recorded_laughie.mp4');
    UploadTask uploadTask = firebaseStorageRef.putFile(fileMedia);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  _saveFile(File fileMedia) async {
    String fileName = 'recorded_laughie.mp4';
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@save File called');
    Directory directory;
    directory = await getExternalStorageDirectory();
    print(
        "--------------------------------------------------------------${directory.path}");
    String newPath = "";
    List<String> folders = directory.path.split('/');
    for (int x = 1; x < folders.length; x++) {
      if (folders[x] != "Android") {
        newPath += "/" + folders[x];
      } else {
        break;
      }
    }
    newPath = newPath + "/Laughie";
    directory = Directory(newPath);
    print(
        "#########################${directory.path}\n &&&&&&&&&&&&&&&&&&&&&&&&&&&${fileMedia.path}");
    File savedFile = File(directory.path + "/$fileName");
    print('-------------------before------------------${savedFile.path}');
    // savedFile = fileMedia;
    print('-------------------after------------------${savedFile.path}');
    try {
      await FirebaseStorage.instance
          .ref()
          .child(
              'recorded_sessions/${FirebaseAuth.instance.currentUser.uid}/recorded_laughie.mp4')
          .putFile(fileMedia);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("))))))))))))))))))))))))))))))))))))))))${e.message}");
    }
    try {
      await FirebaseStorage.instance
          .ref()
          .child(
              'recorded_sessions/${FirebaseAuth.instance.currentUser.uid}/recorded_laughie.mp4')
          .writeToFile(savedFile);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print('(((((((((((((((((((((((((((((((((${e.message}');
    }
    final _saveResult = await ImageGallerySaver.saveFile(savedFile.path);

    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${_saveResult}');
    // if (!await directory.exists()) {
    //   print(
    //       '666666666666666666666666666666666666666 inside directory does snot ');
    //   await directory.create();
    // }
    // if (await directory.exists()) {
    //   print('666666666666666666666666666666666666666 inside directory ');
    //   File savedFile = File(directory.path + "/$fileName");
    //   print(
    //       "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${savedFile.path}\n &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&${fileMedia.path}");
    // }
  }

  Future capture(BuildContext context) async {
    if (fileMedia != null) {
      setState(() {
        this.fileMedia = null;
      });
    }
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
    final result = await pickCameraMedia(context);
    _saveFile(result);
    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
        isRecorded = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoRecorder(
              fileMedia: this.fileMedia,
            ),
          ),
        );
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
                          onPressed: () {
                            setState(() {
                              _isRecordingSelected = true;
                            });
                            print(
                                '@@@@_mRecorder!.isRecording:${_mRecorder.isRecording}');
                            print('@@@@_hasTimeCompleted:${_hasTimeCompleted}');
                            if (_mRecorder.isRecording == false &&
                                _hasTimeCompleted == false) {
                              print('@@@@inside if1');
                              startCounter();
                            } else if (_mRecorder.isRecording == true &&
                                _hasTimeCompleted == false) {
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
                              play();
                            } else if (_mRecorder.isStopped == true &&
                                _hasTimeCompleted == true &&
                                _mPlayer.isStopped == false) {
                              print('@@@@inside if4');
                              stopPlayer();
                            }
                          },
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
                              : 'Recorder is stopped',
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
              ? Center(
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
                              if (fileMedia == null) {
                                checkPermission(context);
                              }
                              if (isRecorded) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoRecorder(
                                      fileMedia: this.fileMedia,
                                    ),
                                  ),
                                );
                              }
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
