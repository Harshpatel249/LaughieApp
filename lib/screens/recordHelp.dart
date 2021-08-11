import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/video_widget.dart';

class RecordHelp extends StatelessWidget {
  //TODO: how to record

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'How to record?',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    final padding = mediaQuery.size.width * 0.05;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final tip1 =
        '1. Your recording should sound like your natural joyful and playful laughter. If it doesn’t, practice and record another Laughie!';
    final tip2 =
        '2. Try to make the Laughie an enjoyable experience! You can add visual props (e.g. a mirror – laughing in front of a mirror), gestures (e.g. moving your arms, or legs, as well as sitting); mental aspects (e.g. thinking about joyful or amusing things, or using humour and jokes to help you to laugh); or social (e.g. laughing together with someone else while using your Laughie).';
    final tip3 =
        '3. This is a new way of laughing and for some might be easier than others. Practice can help.';
    final tip4 =
        '4. Because you will be laughing alone, for all or some of the time, it is good to find a reason to do it! Reason may include for health, happiness, joy, humour, exercise, relaxation, meditation, and energy.';
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: padding, right: padding),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.08,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text('Tips for recording your laughie: '),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    tip1,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    tip2,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    tip3,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    tip4,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Video tutorial: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Container(
                    height: screenHeight * 0.8,
                    child: VideoWidget(
                      screenHeight: screenHeight,
                      url:
                          "https://firebasestorage.googleapis.com/v0/b/laughie-52bd5.appspot.com/o/record_laughie.mp4?alt=media&token=adb27283-b86f-471b-af54-17a91124491a",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
