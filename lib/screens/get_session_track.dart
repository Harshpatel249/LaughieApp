import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/test.dart';

class GetSessionTrack extends StatefulWidget {
  // const GetSessionTrack({Key? key}) : super(key: key);
  @override
  _GetSessionTrackState createState() => _GetSessionTrackState();
}

class _GetSessionTrackState extends State<GetSessionTrack> {
  Future<QuerySnapshot> _initializeFuture = usersRef
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("session_track")
      .get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('session'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _initializeFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (!snapshot.hasData) {
            return CircularProgressBar();
          }
          List<Text> docsData = snapshot.data.docs
              .map((doc) => Text(doc['sessions'][0]['time']))
              .toList();
          print(docsData);
          return ListView(
            children: docsData,
          );
        },
      ),
    );
  }
}
