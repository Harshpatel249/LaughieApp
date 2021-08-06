import 'package:flutter/material.dart';
import 'package:laughie_app/screens/session_builder.dart';

class DailyTrack extends StatelessWidget {
  final int noSessions;

  DailyTrack({
    this.noSessions,
  });
  List<SessionBuilder> getSessionDetails(
      DateTime selectedDay, int totalSessions) {
    print(
        "============================================== getSessionDetails called");
    List<SessionBuilder> sessionsDetails = [];
    if (totalSessions == null) {
      print(" no of sessions is null ");
    } else {
      print("number of session is not null");
      print("+++++++++++++++++++++++++++++++++++++ $totalSessions");
      for (var i = 0; i < totalSessions; i++) {
        final SessionBuilder session1 = SessionBuilder(
          time: '9AM',
          sessionNumber: (i + 1),
          greeting: 'Morning',
          completed: true,
        );
        sessionsDetails.add(session1);
      }
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% $sessionsDetails}');
    }

    return sessionsDetails;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Statistics',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    final bottomBarHeight = MediaQuery.of(context).size.height * 0.08;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
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
                          '3',
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
                          'Wednesday',
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
                Container(
                  // color: Colors.red,
                  child: Column(
                    // children: getSessionDetails(),
                    children: [],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

SimpleDialog dailyTrack(BuildContext context) => SimpleDialog();
