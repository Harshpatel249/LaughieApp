import 'package:flutter/material.dart';
import '../rewidgets/bottomNavBar.dart';

class Test extends StatelessWidget {
  static String id = 'test_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'AppBar',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(id: Test.id),
      body: Text('Hello World!'),
    ));
  }
}
