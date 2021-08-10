import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laughie_app/helper/format_date.dart';
import 'package:laughie_app/models/session.dart';
import 'package:laughie_app/services/firebase/stats_details.dart';
import 'package:table_calendar/table_calendar.dart';

import 'circularProgressBar.dart';
import 'daily_track.dart';

class BuildCalendar extends StatefulWidget {
  final Timestamp startingTimestamp;
  final Timestamp endingTimestamp;
  final double appBarHeight;
  final int userGivenSessions;
  BuildCalendar({
    this.startingTimestamp,
    this.endingTimestamp,
    this.appBarHeight,
    this.userGivenSessions,
  });

  @override
  _BuildCalendarState createState() => _BuildCalendarState();
}

class _BuildCalendarState extends State<BuildCalendar> {
  DateTime focused = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  StatsDetails obj = StatsDetails();
  Map<String, List<Session>> numSessionAttended;
  bool _isLoaded = true;

  _getNumSessionAttended() async {
    // print("here in getnumSessionattn \n ");
    await obj
        .getSessions(widget.startingTimestamp.toDate(), DateTime.now())
        .then((value) {
      numSessionAttended.addAll(value);
      setState(() {
        _isLoaded = true;
      });
    });
    numSessionAttended.forEach((key, value) {
      // print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ key: $key \t value: $value");
    });
    DateTime time = numSessionAttended["06082021"][0].time;

    print(
        "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ${DateFormat.H().format(time)}");
  }

  @override
  void initState() {
    numSessionAttended = {};
    _getNumSessionAttended();
    super.initState();
  }

  List<Session> _getEventsForDay(DateTime day) {
    return numSessionAttended[formatDate(day)];
  }

  _handleOnDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print(selectedDay.toUtc());
    setState(() {
      _selectedDay = selectedDay;
      focused = focusedDay; // update `_focusedDay` here as well
    });
    print(
        "################################### ${numSessionAttended[formatDate(selectedDay)].toString()}");
    showDialog<void>(
        context: context,
        builder: (_) {
          return DailyTrack(
            appBarHeight: widget.appBarHeight,
            sessionsOfDay: numSessionAttended[formatDate(selectedDay)],
            selectedDay: selectedDay,
            userGivenSessions: widget.userGivenSessions,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% inside build of buildCalendar()");
    return LayoutBuilder(builder: (context, constraints) {
      return _isLoaded
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TableCalendar(
                  rowHeight: constraints.maxHeight * 0.146,

                  firstDay: widget.startingTimestamp.toDate().toLocal(),
                  lastDay: widget.endingTimestamp.toDate().toLocal(),
                  focusedDay: focused,
                  eventLoader: _getEventsForDay,

                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: _handleOnDaySelected,
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
                // ..._getEventsForDay(_selectedDay).map((Session session) {
                //   print("################### session: $session");
                //   return Container();
                // }),
              ],
            )
          : CircularProgressBar();
    });
  }
}
