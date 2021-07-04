import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'videoRecorder.dart';

typedef _Fn = void Function();

class RecordScreen extends StatefulWidget {
  static String id = 'record_screen';

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  File fileMedia, savedFile;
  bool isRecorded = false;

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
    return file;
    // Navigator.of(context).pop(file);
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
    final _saveResult = await ImageGallerySaver.saveFile(fileMedia.path);
    savedFile = fileMedia;
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

  double progressValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                      style: ElevatedButton.styleFrom(shape: CircleBorder()),
                      child: Container(
                        // width: 170,
                        // height: 170,
                        width: constraints.maxHeight * 0.475,
                        height: constraints.maxHeight * 0.475,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Icon(
                          Icons.mic,
                          size: constraints.maxHeight * 0.475 * 0.5,
                          color: Color(0xfffbb313),
                        ),
                      ),
                      // onPressed: ,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.07,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.1,
                      child: FittedBox(
                        child: Text(
                          'Record Audio',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
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
                      style: ElevatedButton.styleFrom(shape: CircleBorder()),
                      child: Container(
                        // width: 170,
                        // height: 170,
                        width: constraints.maxHeight * 0.475,
                        height: constraints.maxHeight * 0.475,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
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
