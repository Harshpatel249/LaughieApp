import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laughie_app/screens/audio_player.dart';
import 'package:laughie_app/screens/laughieFeedback.dart';
import 'package:share_plus/share_plus.dart';

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
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
            size: 30,
          ),
          onPressed: () async {
            // final box = context.findRenderObject() as RenderBox;

            // if (widget.filePath.isNotEmpty) {
            //   await Share.shareFiles([fileMedia.path],
            //       text: 'Laughie',
            //       subject: 'Laughie',
            //       sharePositionOrigin:
            //           box.localToGlobal(Offset.zero) & box.size);
            // } else {
            //   await Share.share('File not found',
            //       subject: 'File not found',
            //       sharePositionOrigin:
            //           box.localToGlobal(Offset.zero) & box.size);
            // }
            if (widget.filePath.isNotEmpty) {
              print("########################### ${widget.filePath}");
              await Share.shareFiles([widget.filePath], text: 'Laughie');
            }
          },
        ),
      ],
    );

    final appBarHeight = appBar.preferredSize.height;
    final screenHeight =
        mediaQuery.size.height - appBarHeight - mediaQuery.padding.top;
    final padding = mediaQuery.size.width * 0.05;

    return Scaffold(
      appBar: appBar,
      body: (widget.mediaType == "video")
          ? ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: padding / 2, right: padding / 2),
                      child: Container(
                        height: screenHeight * 0.05,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Laugh along with your laughie!!'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.8,
                      width: double.infinity,
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: VideoWidget(
                        file: fileMedia,
                        screenHeight: screenHeight,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: padding, right: padding),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LaughieFeedback()),
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
                                borderRadius:
                                    BorderRadius.circular(8), // <-- Radius
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : AudioPlayer(appBarHeight, widget.filePath),
    );
  }
}
