import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/helper/format_date.dart';
import 'package:laughie_app/screens/source_page.dart';
import 'package:laughie_app/screens/test.dart';

import '../rewidgets/questionWidget.dart';

/*
* This is feedback for every laughie session
* */

class SessionFeedback extends StatefulWidget {
  @override
  _SessionFeedbackState createState() => _SessionFeedbackState();
}

class _SessionFeedbackState extends State<SessionFeedback> {
  //Updating the user data with the feedback
  _handleSubmit() async {
    DateTime currentDateTime = DateTime.now();
    String fDate = formatDate(currentDateTime);
    List<Map> sessionData = [];
    sessionData.add({
      "time": currentDateTime,
      "q3": 4,
      "q4": 5,
      "q5": 2,
    });
    DocumentSnapshot documentSnapshot = await sessionsRef.doc(fDate).get();
    if (documentSnapshot.exists) {
      try {
        sessionsRef.doc(fDate).update({
          "session_data": FieldValue.arrayUnion(sessionData),
        });
      } on FirebaseException catch (err) {}
    } else {
      try {
        sessionsRef.doc(fDate).set({
          "date": fDate,
          "session_data": sessionData,
        });
      } on FirebaseException catch (err) {}
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SourcePage(),
        ),
        (route) => false);
  }

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                QuestionWidget(
                  question:
                      'Did you laugh for more than 30 seconds of the session?',
                  id: 3,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                QuestionWidget(
                  question:
                      'Did you laugh for the full one minute of the session?',
                  id: 4,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                QuestionWidget(
                  question:
                      'Did you feel more cheerful at the end of the session?',
                  id: 5,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(right: padding, left: padding),
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xfffbb313),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
