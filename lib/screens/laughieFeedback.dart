import 'package:flutter/material.dart';
import '../rewidgets/bottomNavBar.dart';
import '../rewidgets/questionWidget.dart';

class LaughieFeedback extends StatefulWidget {
  @override
  _LaughieFeedbackState createState() => _LaughieFeedbackState();
}

class _LaughieFeedbackState extends State<LaughieFeedback> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Laughie Feedback',
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

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: BottomNavBar(),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                QuestionWidget(
                  question: 'This is a sample question',
                  id: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
