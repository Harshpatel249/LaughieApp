import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laughie_app/helper/format_date.dart';
import 'package:laughie_app/models/session.dart';
import 'package:laughie_app/models/session_track.dart';
import 'package:laughie_app/screens/test.dart';

// to fetch stats details from firestore.
class StatsDetails {
  int temp;
  DateTime startingDate;
  DateTime endingDate;

  Future<List<SessionTrack>> getSessionTrack() async {
    List<SessionTrack> sessionTrack = [];
    DocumentSnapshot userSnapshot =
        await usersRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    Timestamp startingTimestamp = userSnapshot['starting_date'];
    startingDate = startingTimestamp.toDate();

    Timestamp endingTimestamp = userSnapshot['starting_date'];
    endingDate = endingTimestamp.toDate();

    QuerySnapshot querySnapshot = await sessionsRef
        .where("date", isLessThanOrEqualTo: "${formatDate(DateTime.now())}")
        .get();
    querySnapshot.docs.forEach((date) {
      sessionTrack.add(SessionTrack.fromDocument(date));
    });

    return sessionTrack;
  }

  Future<Map<String, List<Session>>> getSessions(
      DateTime start, DateTime focusDay) async {
    Map<String, List<Session>> numSessionsAttended = {};
    List<SessionTrack> sessionTrack = await getSessionTrack();

    return numSessionsAttended;
  }

  //TODO: MarkerBuilders, PrioritizedBuilder, HighlightBuilder, SingleMarkerBuilder

}
