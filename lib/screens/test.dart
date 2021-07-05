import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/screens/record_screen.dart';
import 'package:laughie_app/screens/signIn.dart';
import 'package:laughie_app/screens/signUpMedicalHistory.dart';
import 'package:laughie_app/screens/signUpPersonalDetails.dart';
import 'package:laughie_app/screens/signUpPrescription.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Test extends StatelessWidget {
  static String id = 'test_screen';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        var status;
        if (userSnapshot.hasData) {
          usersRef
              .doc(FirebaseAuth.instance.currentUser.uid)
              .get()
              .then((snapshot) {
            status = (snapshot.data()['signup_status']);
          });
          if (status == 0) {
            return SignUpPersonalDetails();
          } else if (status == 1) {
            return SignUpMedicalHistory();
          } else if (status == 2) {
            return SignUpPrescription();
          } else {
            return RecordScreen();
          }
        }
        return SignIn();
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
