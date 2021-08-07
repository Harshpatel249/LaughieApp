import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laughie_app/screens/session_builder.dart';
import 'package:laughie_app/services/firebase/stats_details.dart';
import 'package:table_calendar/table_calendar.dart';

import 'daily_track.dart';

class BuildCalendar extends StatefulWidget {
  final Timestamp startingTimestamp;
  final Timestamp endingTimestamp;
  final double appBarHeight;

  BuildCalendar({
    this.startingTimestamp,
    this.endingTimestamp,
    this.appBarHeight,
  });

  @override
  _BuildCalendarState createState() => _BuildCalendarState();
}

class _BuildCalendarState extends State<BuildCalendar> {
  DateTime focused = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  StatsDetails obj = StatsDetails();
  List<SessionBuilder> getSessionDetails(int totalSessions) {
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
  void initState() {
    var numSessionAttended = obj
        .getSessions(widget.startingTimestamp.toDate(), DateTime.now())
        .then((value) {
      value.forEach((key, value) {
        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ key: $key \t value: $value');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return TableCalendar(
        rowHeight: constraints.maxHeight * 0.146,

        firstDay: widget.startingTimestamp.toDate().toLocal(),
        lastDay: widget.endingTimestamp.toDate().toLocal(),
        focusedDay: focused,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          print(selectedDay.toUtc());
          setState(() {
            _selectedDay = selectedDay;
            focused = focusedDay; // update `_focusedDay` here as well
          });
          showDialog<void>(
              context: context,
              builder: (_) {
                return DailyTrack(
                  appBarHeight: widget.appBarHeight,
                );
              });
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
      );
    });
  }
}
