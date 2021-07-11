import 'package:flutter/cupertino.dart';
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

    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.01, bottom: screenHeight * 0.01),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        height: screenHeight * 0.10,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                color: completed ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(
              width: padding / 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight * 0.025,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '$greeting',
                      style: TextStyle(color: Colors.black45, fontSize: 12),
                    ),
                  ),
                ),
                Container(
                  height: (screenHeight * 0.04),
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      'Session $sessionNumber',
                      style: TextStyle(
                          color: completed ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.025,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '$time',
                      style: TextStyle(color: Colors.black45, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              completed ? Icons.done : Icons.close,
              color: completed ? Color(0xff3ba55c) : Color(0xffee5655),
              size: 28.0,
            ),
            SizedBox(
              width: padding,
            ),
          ],
        ),
      ),
    );
  }
}

// Card(
// shadowColor: Colors.white,
// semanticContainer: false,
// color: Color(0xffF6F6F6),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(15.0),
// ),
// child: ListTile(
// contentPadding: EdgeInsets.only(right: 10),
// dense: true,
// minVerticalPadding: 0,
// minLeadingWidth: 0.0,
// horizontalTitleGap: 0,
// leading: SizedBox(
// height: double.infinity,
// width: 10,
// child: Container(
// color: Colors.orange,
// ),
// ),
// title: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// '$greeting',
// style: TextStyle(
// color: Color(0xffc2c2c2),
// fontWeight: FontWeight.bold,
// fontSize: 12.0,
// ),
// ),
// Text(
// 'Session $sessionNumber',
// style: TextStyle(
// color: completed ? Color(0xff3ba55c) : Color(0xffee5655),
// fontWeight: FontWeight.bold,
// fontSize: 18.0,
// ),
// ),
// Text(
// '$time',
// style: TextStyle(
// color: Color(0xffc2c2c2),
// fontWeight: FontWeight.bold,
// fontSize: 12.0,
// ),
// ),
// ],
// ),
// trailing: Icon(
// completed ? Icons.done : Icons.close,
// color: completed ? Color(0xff3ba55c) : Color(0xffee5655),
// // size: 28.0,
// ),
// ),
// ),
