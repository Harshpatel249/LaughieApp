import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laughie_app/helper/format_date.dart';
import 'package:laughie_app/models/session_track.dart';
import 'package:laughie_app/screens/test.dart';

class StatsDetails {
  Future<List<SessionTrack>> getSessionTrack() async {
    print("***************************** inside getSessionTrack");
    List<SessionTrack> sessionTrack = [];
    QuerySnapshot querySnapshot = await sessionsRef
        .where("date", isLessThanOrEqualTo: "${formatDate(DateTime.now())}")
        .get();
    // print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${querySnapshot.size}");
    querySnapshot.docs.forEach((date) {
      // print(
      //     '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${date['session_data']}');
      sessionTrack.add(SessionTrack.fromDocument(date));
    });

    // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${sessionTrack.length}");

    return sessionTrack;
  }
}
