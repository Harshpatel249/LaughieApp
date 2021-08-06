import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/helper/format_date.dart';
import 'package:laughie_app/screens/source_page.dart';
import 'package:laughie_app/screens/test.dart';

import '../rewidgets/questionWidget.dart';

class LaughieFeedback extends StatefulWidget {
  @override
  _LaughieFeedbackState createState() => _LaughieFeedbackState();
}

class _LaughieFeedbackState extends State<LaughieFeedback> {
  _handleSubmit() async {
    // TODO: Don't allow to submit until and unless something is selected.
    print("============================================== handleSubmit called");
    DateTime currentDateTime = DateTime.now();
    String fDate = formatDate(currentDateTime);
    List<Map> sessionData = [];
    sessionData.add({
      "time": currentDateTime,
      "q1": 4,
      "q2": 5,
    });
    DocumentSnapshot documentSnapshot = await sessionsRef.doc(fDate).get();
    if (documentSnapshot.exists) {
      sessionsRef.doc(fDate).update({
        "session_data": FieldValue.arrayUnion(sessionData),
      });
    } else {
      sessionsRef.doc(fDate).set({
        "date": fDate,
        "session_data": sessionData,
      });
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
                  question: 'Did you enjoy recording the Laughie?',
                  id: 1,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                QuestionWidget(
                  question:
                      'Did you laugh for the full one minute of recording?',
                  id: 2,
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
