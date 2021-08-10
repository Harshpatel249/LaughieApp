import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laughie_app/helper/format_date.dart';
import 'package:laughie_app/rewidgets/bottomNavBar.dart';
import 'package:laughie_app/rewidgets/build_calendar.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/test.dart';
import 'package:laughie_app/services/firebase/stats_details.dart';

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
  DateTime focused = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  int _numSessions;
  bool _isFetched = false;
  StatsDetails _statsDetailsObject = StatsDetails();

  _fetchDetails() async {
    //TODO: remove this method and implement its functionality in user model
    DocumentSnapshot userSnapshot =
        await usersRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    _startingTimestamp = userSnapshot['starting_date'];
    _endingTimestamp = userSnapshot['ending_date'];
    _numSessions = userSnapshot['sessions'];
    startMonth =
        "${DateFormat.MMM().format(_startingTimestamp.toDate())}'${DateFormat('yy').format(_startingTimestamp.toDate())}";
    endMonth =
        "${DateFormat.MMM().format(_endingTimestamp.toDate())}'${DateFormat('yy').format(_endingTimestamp.toDate())}";
    _statsDetailsObject.getSessionTrack().then((sessionTrack) {
      sessionTrack.forEach((date) {
        print(
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${date.containsDate(formatDate(DateTime.now()))}");
      });
      setState(() {
        _isFetched = true;
        focused = _startingTimestamp.toDate().toUtc();
      });
    });
  }

  @override
  void initState() {
    _fetchDetails();
    super.initState();
  }

  // _handleOnSelectedDay

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
    final _appBarHeight = appBar.preferredSize.height;
    final screenHeight = mediaQuery.size.height -
        _appBarHeight -
        mediaQuery.padding.top -
        bottomBarHeight;
    final padding = mediaQuery.size.width * 0.05;

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
                          height: screenHeight * 0.5,
                          width: double.infinity,
                          // color: Colors.red,
                          child: BuildCalendar(
                            appBarHeight: _appBarHeight,
                            startingTimestamp: _startingTimestamp,
                            endingTimestamp: _endingTimestamp,
                            userGivenSessions: _numSessions,
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
                                  //TODO: calculate this

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
                                  //TODO: calculate this

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
