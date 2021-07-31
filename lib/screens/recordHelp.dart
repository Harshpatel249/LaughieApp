import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'How to record?',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    final padding = mediaQuery.size.width * 0.05;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: ListView(
          children: [
            Column(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
