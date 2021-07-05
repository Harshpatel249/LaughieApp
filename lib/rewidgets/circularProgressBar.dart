import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(
          backgroundColor: Color(0xfffbb313),
          valueColor: AlwaysStoppedAnimation(
            Color(0xff222223),
          ),
        ),
      ),
    );
  }
}
