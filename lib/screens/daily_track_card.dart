import 'package:flutter/material.dart';
import 'session_builder.dart';

class DailyTrackCard extends StatelessWidget {
  final String startMonth;
  final String endMonth;
  final String currentMonth;

  DailyTrackCard({
    this.startMonth,
    this.endMonth,
    this.currentMonth,
  });
  List<SessionBuilder> getSessionDetails() {
    List<SessionBuilder> sessionsDetails = [];
    final SessionBuilder session1 = SessionBuilder(
      time: '9AM',
      sessionNumber: 1,
      greeting: 'Morning',
      completed: true,
    );
    sessionsDetails.add(session1);
    final SessionBuilder session2 = SessionBuilder(
      time: '1 PM',
      sessionNumber: 2,
      greeting: 'Afternoon',
      completed: true,
    );
    sessionsDetails.add(session2);
    final SessionBuilder session3 = SessionBuilder(
      time: '8 PM',
      sessionNumber: 3,
      greeting: 'Evening',
      completed: false,
    );
    sessionsDetails.add(session3);
    return sessionsDetails;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Daily Sessions',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final padding = mediaQuery.size.width * 0.05;

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              height: screenHeight * 0.10,
              padding: EdgeInsets.only(top: padding / 2, bottom: padding / 2),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  '$startMonth - $endMonth',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Text(
              '$currentMonth',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Card(
              color: Color(0xff222223),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 15.0,
              shadowColor: Colors.black,
              child: Container(
                padding: EdgeInsets.only(left: padding, right: padding),
                height: screenHeight * 0.50,
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
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: getSessionDetails(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
