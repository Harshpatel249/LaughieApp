import 'dart:convert';

class Session {
  bool hasAttended;
  int q1;
  int q2;
  DateTime time;

  Session({
    this.hasAttended,
    this.q1,
    this.q2,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'hasAttended': hasAttended,
      'q1': q1,
      'q2': q2,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      hasAttended: map['hasAttended'],
      q1: map['q1'],
      q2: map['q2'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Session(hasAttended: $hasAttended, q1: $q1, q2: $q2, time: $time)';
  }
}
