import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laughie_app/constants/style.dart';
import 'package:laughie_app/helper/format_date.dart';
import 'package:laughie_app/models/session.dart';
import 'package:table_calendar/table_calendar.dart';

import 'daily_track.dart';

class BuildCalendar extends StatefulWidget {
  final Timestamp startingTimestamp;
  final Timestamp endingTimestamp;
  final double appBarHeight;
  final int userGivenSessions;
  final Map<String, List<Session>> numSessionAttended;

  BuildCalendar({
    this.startingTimestamp,
    this.endingTimestamp,
    this.appBarHeight,
    this.userGivenSessions,
    this.numSessionAttended,
  });

  @override
  _BuildCalendarState createState() => _BuildCalendarState();
}

class _BuildCalendarState extends State<BuildCalendar> {
  DateTime focused = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  // StatsDetails obj = StatsDetails();
  // Map<String, List<Session>> numSessionAttended;
  // bool _isLoaded = true;

  @override
  void initState() {
    super.initState();
  }

  List<Session> _getEventsForDay(DateTime day) {
    return widget.numSessionAttended[formatDate(day)];
  }

  _handleOnDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      focused = focusedDay; // update `_focusedDay` here as well
    });
    print(
        "################################### ${widget.numSessionAttended[formatDate(selectedDay)].toString()}");

    if (parseDate(selectedDay).isAfter(parseDate(DateTime.now()))) {
      return;
    }
    showDialog<void>(
        context: context,
        builder: (_) {
          return DailyTrack(
            appBarHeight: widget.appBarHeight,
            sessionsOfDay: widget.numSessionAttended[formatDate(selectedDay)],
            selectedDay: selectedDay,
            userGivenSessions: widget.userGivenSessions,
          );
        });
  }

  Widget _todayBuilder(
      BuildContext context, DateTime today, DateTime selectedDay) {
    // print("!!!!!!!!!!!!!!!!!!!!!!!!!! day1: $selectedDay \n day2: $day2");
    return Center(
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          shape: BoxShape.circle,

          color: kPrimaryColor,
        ),
        child: Center(
          child: Text(
            today.day.toString(),
            style: TextStyle(
              color: kPrimaryTextColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectedBuilder(
      BuildContext contest, DateTime selectedDay, DateTime day2) {
    // print("!!!!!!!!!!!!!!!!!!!!!!!!!! day1: $day1 \n day2: $day2");
    return Center(
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          shape: BoxShape.circle,

          color: kPrimaryTextColor,
        ),
        child: Center(
          child: Text(
            selectedDay.day.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMarkers(
      BuildContext context, DateTime day, List<Session> sessions) {
    // print("@@@@@@@@@@@@@@@@@@@@ ${sessions.toString()}");
    if (sessions.isNotEmpty) {
      return Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: sessions.map((session) {
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(5),
                shape: BoxShape.circle,
                color: kDoneColor,
              ),
            ),
          );
        }).toList(),
        //     (
        //
        // child: Text(sessions.length.toString()),
        // )
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% inside build of buildCalendar()");
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            calendarBuilders: CalendarBuilders(
              // outsideBuilder: _outsideBuilder,
              markerBuilder: _buildMarkers,
              todayBuilder: _todayBuilder,
              selectedBuilder: _selectedBuilder,
            ),
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
                  DateFormat.MMMM(locale).format(date),
              titleTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // ..._getEventsForDay(_selectedDay).map((Session session) {
          //   print("################### session: $session");
          //   return Container();
          // }),
        ],
      );
    });
  }
}
