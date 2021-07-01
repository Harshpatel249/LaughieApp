import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../rewidgets/video_widget.dart';
import 'dart:io';
import '../rewidgets/bottomNavBar.dart';

class VideoRecorder extends StatefulWidget {
  static String id = 'video_recorder';
  File fileMedia;
  VideoRecorder({this.fileMedia});
  @override
  _VideoRecorderState createState() =>
      _VideoRecorderState(fileMedia: this.fileMedia);
}

class _VideoRecorderState extends State<VideoRecorder> {
  File fileMedia;
  _VideoRecorderState({this.fileMedia});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recorded Video'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 550,
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: fileMedia == null
                      ? Icon(
                          Icons.photo,
                          size: 120,
                        )
                      : VideoWidget(fileMedia)),
            ],
          ),
        ),
      ),
    );
  }
}
