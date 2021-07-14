import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/record_screen.dart';
import 'package:laughie_app/screens/session_screen.dart';
import 'package:laughie_app/screens/test.dart';
import 'package:permission_handler/permission_handler.dart';

class SourcePage extends StatefulWidget {
  // const SourcePage({Key? key}) : super(key: key);

  @override
  _SourcePageState createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {
  bool _recordLaughieStatus;
  bool _isFetched = false;
  String _filePath;
  String _mediaType;

  _getRecordLaghieStatus() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await usersRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    final userData = documentSnapshot.data();
    // Map<String, dynamic> userData =
    //     documentSnapshot.data() as Map<String, dynamic>;
    setState(() {
      _recordLaughieStatus = userData['has_recorded_laughie'];
    });

    print(
        "#############################################$_recordLaughieStatus}");
    if (_recordLaughieStatus) {
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        await Permission.storage.request();
      }
      if (await Permission.storage.isGranted) {
        _filePath = userData['filePath'];
        _mediaType = userData['media'];
        print(
            "#############################################$_filePath \n ^^^^^^^^^^^^^^^^^^^^^^$_mediaType}");
      }
    }
    setState(() {
      _isFetched = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getRecordLaghieStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isFetched
        ? _recordLaughieStatus
            ? SessionScreen(
                filePath: _filePath,
                mediaType: _mediaType,
              )
            : RecordScreen()
        : CircularProgressBar();
  }
}
