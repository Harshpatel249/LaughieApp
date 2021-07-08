import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/test.dart';
import 'package:table_calendar/table_calendar.dart';
import 'session_builder.dart';
import '../rewidgets/bottomNavBar.dart';
import 'daily_track_card.dart';

class StatsPage extends StatefulWidget {
  static String id = 'stats_page';
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  // CalendarController _controller = CalendarController();
  int _counter = 0;
  String startMonth = "May'21";
  String endMonth = "July'21";
  double timeSpent = 15;
  double timeLeft = 28;
  Timestamp _startingTimestamp;
  Timestamp _endingTimestamp;
  DateTime focused = null;
  DateTime _selectedDay = null;
  int noSessions;
  bool _isFetched = false;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  _fetchDetails() async {
    DocumentSnapshot userSnapshot =
        await usersRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    _startingTimestamp = userSnapshot['starting_date'];
    _endingTimestamp = userSnapshot['ending_date'];
    noSessions = userSnapshot['sessions'];
    startMonth =
        "${DateFormat.MMM().format(_startingTimestamp.toDate())}'${DateFormat('yy').format(_startingTimestamp.toDate())}";
    endMonth =
        "${DateFormat.MMM().format(_endingTimestamp.toDate())}'${DateFormat('yy').format(_endingTimestamp.toDate())}";
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${DateTime.now().subtract(Duration(days: 30))}");
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${(_endingTimestamp.toDate().toUtc())}");
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $noSessions");
    setState(() {
      _isFetched = true;
      focused = _startingTimestamp.toDate().toUtc();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchDetails();
    super.initState();
  }

  List<SessionBuilder> getSessionDetails() {
    List<SessionBuilder> sessionsDetails = [];

    for (var i = 0; i < noSessions; i++) {
      final SessionBuilder session1 = SessionBuilder(
        time: '9AM',
        sessionNumber: (i + 1),
        greeting: 'Morning',
        completed: true,
      );
      sessionsDetails.add(session1);
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

    SimpleDialog dailyTrack = SimpleDialog(
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
                    children: getSessionDetails(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: BottomNavBar(
          id: StatsPage.id,
        ),
        body: _isFetched
            ? Container(
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
                          padding: EdgeInsets.only(
                              top: padding / 2, bottom: padding / 2),
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

                            firstDay: _startingTimestamp.toDate().toUtc(),
                            // firstDay:
                            //     DateTime.now().subtract(Duration(days: 30)),

                            // firstDay: DateTime.utc(2021, 5, 1),
                            lastDay: _endingTimestamp.toDate().toUtc(),
                            focusedDay: focused,
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              print(selectedDay.toUtc());
                              setState(() {
                                _selectedDay = selectedDay;
                                focused =
                                    focusedDay; // update `_focusedDay` here as well
                              });
                              showDialog<void>(
                                  context: context,
                                  builder: (context) => dailyTrack);
                            },

                            // onDaySelected: (date, events) {
                            //   print(date.toUtc());
                            //   setState(() {
                            //     focused = date.toUtc();
                            //   }); //On click services
                            // },
                            onPageChanged: (focusedDay) {
                              focused = focusedDay;
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
                          height: screenHeight * 0.14,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
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
                          height: screenHeight * 0.14,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
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
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : CircularProgressBar(),
      ),
    );
  }
}
