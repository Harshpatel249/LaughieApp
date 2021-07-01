import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

typedef _Fn = void Function();

class RecordScreen extends StatefulWidget {
  static String id = 'record_screen';

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  final String _mPath = 'flutter_sound_example.aac';

  double progressValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Widget getRecordElement(String displayTxt, IconData icon, void func()) {
  //   return LayoutBuilder(
  //     builder: (ctx, constraints) {
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(shape: CircleBorder()),
  //             child: Container(
  //               // width: 170,
  //               // height: 170,
  //               width: constraints.maxHeight * 0.475,
  //               height: constraints.maxHeight * 0.475,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: Theme.of(context).buttonColor,
  //               ),
  //               child: Icon(
  //                 icon,
  //                 size: constraints.maxHeight * 0.475 * 0.5,
  //                 color: Theme.of(context).primaryColor,
  //               ),
  //             ),
  //             onPressed: func,
  //           ),
  //           SizedBox(
  //             height: constraints.maxHeight * 0.07,
  //           ),
  //           FittedBox(
  //             child: Text(
  //               displayTxt,
  //               style: Theme.of(context).textTheme.headline6,
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
            // child: getRecordElement(
            //   // 'Record Audio',
            //   _mRecorder!.isRecording
            //       ? 'Recording in progress'
            //       : 'Recorder is stopped',
            //   _mRecorder!.isRecording ? Icons.stop : Icons.mic,
            //   getRecorderFn,
            //   // () {
            //   //   print('Column mic');
            //   //   getRecorderFn();
            //   //   print('after Column mic');
            //   // },
            // ),
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
                      // onPressed: ,
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
            // child: getRecordElement(
            //   // 'Record Video',
            //   _mPlayer!.isPlaying
            //       ? 'Playback in progress'
            //       : 'Player is stopped',
            //   _mPlayer!.isPlaying ? Icons.stop : Icons.play_arrow,
            //   // Icons.videocam,
            //   getPlaybackFn,
            //   // () {
            //   //   print('Column video');
            //   //   getPlaybackFn();
            //   //   print('after Column video');
            //   // },
            // ),
          ),
        ],
      ),
    );
  }
}
