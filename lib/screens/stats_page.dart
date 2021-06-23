import 'package:flutter/material.dart';
import '../rewidgets/bottomNavBar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'daily_track_card.dart';

class StatsPage extends StatefulWidget {
  static String id = 'stats_page';
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int _counter = 0;
  String startMonth = "May'21";
  String endMonth = "July'21";
  double timeSpent = 15;
  double timeLeft = 28;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: BottomNavBar(
          id: StatsPage.id,
        ),
        body: Container(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.10,
                    padding:
                        EdgeInsets.only(top: padding / 2, bottom: padding / 2),
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
                  Container(
                    child: TableCalendar(
                      rowHeight: screenHeight * 0.08,
                      firstDay: DateTime.utc(2021, 4, 1),
                      lastDay: DateTime.utc(2021, 6, 31),
                      focusedDay: DateTime.now(),
                      onDaySelected: (date, events) {
                        print(date.toUtc()); //On click services
                      },
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.MMM(locale).format(date),
                        titleTextStyle: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: padding,
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Time spent on Laughie',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              '$timeSpent mins',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFfbb313),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: padding,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: padding,
                          ),
                          FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              'Days left',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              '$timeLeft days',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFfbb313),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: padding,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.08,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DailyTrackCard(
                              startMonth: this.startMonth,
                              endMonth: this.endMonth,
                              currentMonth: 'May',
                            ),
                          ),
                        );
                      },
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          'Daily track',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 100),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xfffbb313),
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // <-- Radius
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30)),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
