import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/signIn.dart';
import 'package:laughie_app/screens/signUpMedicalHistory.dart';
import 'package:laughie_app/screens/signUpPersonalDetails.dart';
import 'package:laughie_app/screens/signUpPrescription.dart';
import 'package:laughie_app/screens/source_page.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final sessionsRef = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser.uid)
    .collection('sessions');
final storageRef = FirebaseStorage.instance.ref('profile_pictures');

class Test extends StatefulWidget {
  static String id = 'test_screen';

  @override
  _TestState createState() => _TestState();
}

// All the firebase instances are created here.
// Also this file keeps track of the user progress while signing up, saves as signup_status
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
              .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
            setState(() {
              status = (snapshot.data()['signup_status']);
              // print(status);
            });
          });

          if (status == 0) {
            return SignUpPersonalDetails();
          } else if (status == 1) {
            return SignUpMedicalHistory();
          } else if (status == 2) {
            return SignUpPrescription();
          } else if (status == 3) {
            return SourcePage();
          } else {
            return CircularProgressBar();
          }
        }
        return SignIn();
      },
    );
  }
}
