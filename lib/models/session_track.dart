import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:laughie_app/models/session.dart';

class SessionTrack {
  final String date;
  final List<Session> sessionData;
  SessionTrack({
    @required this.date,
    @required this.sessionData,
  });

  factory SessionTrack.fromDocument(DocumentSnapshot doc) {
    List<Session> sessionData = [];
    List<dynamic> jsonSessionData = doc['session_data'];
    jsonSessionData.forEach((jsonSession) {
      sessionData.add(Session.fromMap(jsonSession));
    });
    return SessionTrack(
      date: doc['date'],
      sessionData: sessionData,
    );
  }
  bool containsDate(String date) {
    if (this.date == date) {
      return true;
    } else {
      return false;
    }
  }
}
