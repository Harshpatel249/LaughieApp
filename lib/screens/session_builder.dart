import 'package:flutter/material.dart';

class SessionBuilder extends StatelessWidget {
  final String greeting;
  final int sessionNumber;
  final String time;
  final bool completed;

  SessionBuilder({
    this.greeting,
    this.sessionNumber,
    this.time,
    this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orange,
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        shadowColor: Colors.white,
        semanticContainer: false,
        color: Color(0xffF6F6F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(right: 10),
          dense: true,
          minVerticalPadding: 0,
          minLeadingWidth: 0.0,
          horizontalTitleGap: 0,
          leading: Container(
            width: 10.0,
            color: Colors.orange,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting',
                style: TextStyle(
                  color: Color(0xffc2c2c2),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              Text(
                'Session $sessionNumber',
                style: TextStyle(
                  color: completed ? Color(0xff3ba55c) : Color(0xffee5655),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                '$time',
                style: TextStyle(
                  color: Color(0xffc2c2c2),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          trailing: Icon(
            completed ? Icons.done : Icons.close,
            color: completed ? Color(0xff3ba55c) : Color(0xffee5655),
            // size: 28.0,
          ),
        ),
        //  Row(
        //           // mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             SizedBox(
        //               width: 10.0,
        //             ),

        //             Spacer(),

        //           ],
        //         ),
      ),
    );
  }
}
