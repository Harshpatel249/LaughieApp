import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/homePage.dart';
import 'package:laughie_app/screens/record_screen.dart';
import 'package:laughie_app/screens/test.dart';
import 'package:permission_handler/permission_handler.dart';

/*
* Checks if the user has already recorded a laughie or not.
* If he has, check the recorded file exists at the saved path or not.
* */
class SourcePage extends StatefulWidget {
  @override
  _SourcePageState createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {
  bool _recordLaughieStatus;
  bool _isFetched = false;
  String _filePath;
  String _mediaType;

  //Fetching the laughie status and location
  _getRecordLaghieStatus() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await usersRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    final userData = documentSnapshot.data();
    setState(() {
      _recordLaughieStatus = userData['has_recorded_laughie'];
    });

    if (_recordLaughieStatus) {
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        await Permission.storage.request();
      }
      if (await Permission.storage.isGranted) {
        _filePath = userData['filePath'];
        _mediaType = userData['media'];
      }
    }
    setState(() {
      _isFetched = true;
    });
  }

  @override
  void initState() {
    _getRecordLaghieStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Routing based on laughie status
    return _isFetched
        ? _recordLaughieStatus
            ? HomePage(
                filePath: _filePath,
                mediaType: _mediaType,
              )
            : RecordScreen()
        : CircularProgressBar();
  }
}
