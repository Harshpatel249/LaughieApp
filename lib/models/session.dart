import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Session {
  int q1;
  int q2;
  DateTime time;

  Session({
    this.q1,
    this.q2,
    this.time,
  });

  Session copyWith({
    int q1,
    int q2,
    DateTime time,
  }) {
    return Session(
      q1: q1 ?? this.q1,
      q2: q2 ?? this.q2,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'q1': q1,
      'q2': q2,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    Timestamp timeStamp = map['time'];
    return Session(
      q1: map['q1'],
      q2: map['q2'],
      time: timeStamp.toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));

  @override
  String toString() => 'Session(q1: $q1, q2: $q2, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Session &&
        other.q1 == q1 &&
        other.q2 == q2 &&
        other.time == time;
  }

  @override
  int get hashCode => q1.hashCode ^ q2.hashCode ^ time.hashCode;
}
