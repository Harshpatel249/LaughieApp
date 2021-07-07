import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/signIn.dart';
import 'package:laughie_app/screens/signUpMedicalHistory.dart';
import 'package:laughie_app/screens/signUpPersonalDetails.dart';
import 'package:laughie_app/screens/signUpPrescription.dart';
import 'package:laughie_app/screens/stats_page.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Test extends StatefulWidget {
  static String id = 'test_screen';

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  var status = 4;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData) {
          usersRef
              .doc(FirebaseAuth.instance.currentUser.uid)
              .get()
              .then((snapshot) {
            setState(() {
              status = (snapshot.data()['signup_status']);
              print(status);
            });
          });
          if (status == 0) {
            return SignUpPersonalDetails();
          } else if (status == 1) {
            return SignUpMedicalHistory();
          } else if (status == 2) {
            return SignUpPrescription();
          } else if (status == 3) {
            return StatsPage();
          } else {
            return CircularProgressBar();
          }
        } else {
          return SignIn();
        }
      },
    );
  }
}
// SafeArea(
// child: Scaffold(
// appBar: AppBar(
// title: Text(
// 'AppBar',
// style: TextStyle(color: Colors.black),
// ),
// centerTitle: true,
// ),
// bottomNavigationBar: BottomNavBar(id: Test.id),
// body: Text('Hello World!'),
// ))
