import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laughie_app/models/session.dart';
import 'package:laughie_app/screens/session_builder.dart';

// renders a dialog box containing session data of the selected day
class DailyTrack extends StatelessWidget {
  final double appBarHeight;
  final List<Session> sessionsOfDay;
  final DateTime selectedDay;
  final int userGivenSessions;
  DailyTrack({
    this.appBarHeight,
    this.sessionsOfDay,
    this.selectedDay,
    this.userGivenSessions,
  });
  List<SessionBuilder> getSessionDetails(int totalSessions) {
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
    //TODO: implement noOfSessionAttended > maxSessions
    if (sessionsOfDay.length < userGivenSessions) {
      for (var i = sessionsOfDay.length; i < userGivenSessions; i++) {
        sessionsDetails.add(SessionBuilder(
          sessionNumber: i + 1,
          dateTime: null,
          completed: false,
        ));
      }
    }

    return sessionsDetails;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomBarHeight = MediaQuery.of(context).size.height * 0.08;
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height -
        appBarHeight -
        mediaQuery.padding.top -
        bottomBarHeight;
    final padding = mediaQuery.size.width * 0.05;
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Container(
          height: screenHeight * 0.55,
          width: screenWidth * .75,
          child: Card(
            color: Color(0xff222223),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 15.0,
            shadowColor: Colors.black,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxWidth * 0.05,
                    horizontal: constraints.maxWidth * 0.1,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.04,
                      ),
                      Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "${DateFormat('d MMM').format(selectedDay)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Spacer(),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              '${DateFormat.EEEE().format(selectedDay)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                        height: screenHeight * 0.01,
                      ),
                      Container(
                        height: constraints.maxHeight * .75,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: getSessionDetails(sessionsOfDay.length),
                        ),
                      ),
                    ],
                  ),
                );
              },
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
