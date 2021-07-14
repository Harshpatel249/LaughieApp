import 'package:flutter/material.dart';

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
        'Feedback',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final padding = mediaQuery.size.width * 0.05;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: ListView(
          children: [
            Column(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
