import 'package:flutter/material.dart';
import '../rewidgets/bottomNavBar.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Text('Hello World!'),
    ));
  }
}
