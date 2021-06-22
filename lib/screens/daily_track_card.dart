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
      greeting: 'Good Morning',
      completed: true,
    );
    sessionsDetails.add(session1);
    final SessionBuilder session2 = SessionBuilder(
      time: '1 PM',
      sessionNumber: 2,
      greeting: 'Good Afternoon',
      completed: true,
    );
    sessionsDetails.add(session2);
    final SessionBuilder session3 = SessionBuilder(
      time: '8 PM',
      sessionNumber: 3,
      greeting: 'Good Evening',
      completed: false,
    );
    sessionsDetails.add(session3);
    return sessionsDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Session Track',
          style: TextStyle(
            color: Color(0xff222223),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16.0),
              child: Text(
                '$startMonth - $endMonth',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
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
              height: 20.0,
            ),
            Card(
              color: Color(0xff222223),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 15.0,
              shadowColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Wednesday',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
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
