import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/screens/record_screen.dart';
import 'package:laughie_app/screens/signIn.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Test extends StatelessWidget {
  static String id = 'test_screen';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData) {
          return RecordScreen();
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
