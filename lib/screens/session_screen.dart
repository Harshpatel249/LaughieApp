import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/bottomNavBar.dart';

import '../rewidgets/video_widget.dart';

class SessionScreen extends StatefulWidget {
  static String id = 'session_screen';
  final String mediaType;
  final String filePath;

  SessionScreen({
    this.filePath,
    this.mediaType,
  });

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    File fileMedia = File(widget.filePath);
    // print("%%%%%%%%%%%%%%%%%%%%%% session ${widget.filePath}");
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Laughie Session',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    final bottomBarHeight = MediaQuery.of(context).size.height * 0.08;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        bottomBarHeight;
    final padding = mediaQuery.size.width * 0.05;

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: BottomNavBar(
        id: SessionScreen.id,
      ),
      body: (widget.mediaType == "video")
          ? Container(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: screenHeight * 0.8,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      child: VideoWidget(
                        file: fileMedia,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
