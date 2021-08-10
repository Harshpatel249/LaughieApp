import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laughie_app/models/session.dart';
import 'package:laughie_app/screens/session_builder.dart';

class DailyTrack extends StatelessWidget {
  // final int noSessions;
  final double appBarHeight;
  final List<Session> sessionsOfDay;
  final DateTime selectedDay;
  final int userGivenSessions;
  DailyTrack({
    // this.noSessions,

    this.appBarHeight,
    this.sessionsOfDay,
    this.selectedDay,
    this.userGivenSessions,
  });
  List<SessionBuilder> getSessionDetails(int totalSessions) {
    if (sessionsOfDay.length < userGivenSessions) {
      //TODO: implement this condition

    }
    List<SessionBuilder> sessionsDetails = [];
    int i = 1;
    sessionsOfDay.forEach((session) {
      sessionsDetails.add(
        SessionBuilder(
          completed: true,
          dateTime: session.time,
          sessionNumber: i,
        ),
      );
      i++;
    });
    for (var i = 0; i < totalSessions; i++) {
      // final SessionBuilder session1 = SessionBuilder(
      //   // dateTime: '9AM',
      //   sessionNumber: (i + 1),
      //   greeting: 'Morning',
      //   completed: true,
      // );
      // sessionsDetails.add(session1);
    }
    // print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% $sessionsDetails}');

    return sessionsDetails;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomBarHeight = MediaQuery.of(context).size.height * 0.08;

    final screenHeight = mediaQuery.size.height -
        appBarHeight -
        mediaQuery.padding.top -
        bottomBarHeight;
    final padding = mediaQuery.size.width * 0.05;
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Card(
          color: Color(0xff222223),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 15.0,
          shadowColor: Colors.black,
          child: Container(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    Container(
                      height: screenHeight * 0.05,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          selectedDay.day.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: screenHeight * 0.05,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          '${DateFormat.EEEE().format(selectedDay)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white,
                  height: screenHeight * 0.01,
                ),
                if (sessionsOfDay == null)
                  Text(
                    "No Sessions were attended on this day",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                else
                  Container(
                    // color: Colors.red,
                    child: Column(
                      children: getSessionDetails(sessionsOfDay.length),
                      //TODO: make this dynamic
                      // children: [],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget dailyTrack(BuildContext context) {
  return SimpleDialog();
}
