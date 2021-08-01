import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SessionTrack {
  final String date;
  final List<dynamic> sessionData;
  SessionTrack({
    @required this.date,
    @required this.sessionData,
  });

  factory SessionTrack.fromDocument(DocumentSnapshot doc) {
    return SessionTrack(
      date: doc['date'],
      sessionData: doc['session_data'],
    );
  }

  SessionTrack copyWith({
    String date,
    List<Map<dynamic, dynamic>> sessionData,
  }) {
    return SessionTrack(
      date: date ?? this.date,
      sessionData: sessionData ?? this.sessionData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'sessionData': sessionData,
    };
  }

  factory SessionTrack.fromMap(Map<String, dynamic> map) {
    return SessionTrack(
      date: map['date'],
      sessionData:
          List<Map<dynamic, dynamic>>.from(map['sessionData']?.map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionTrack.fromJson(String source) =>
      SessionTrack.fromMap(json.decode(source));

  @override
  String toString() => 'SessionTrack(date: $date, sessionData: $sessionData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionTrack &&
        other.date == date &&
        listEquals(other.sessionData, sessionData);
  }

  @override
  int get hashCode => date.hashCode ^ sessionData.hashCode;
}
