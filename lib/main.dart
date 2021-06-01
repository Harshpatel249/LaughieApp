import 'package:flutter/material.dart';
import 'screens/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Color(0xfffbb313),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        bottomAppBarColor: Color(0xFFf6f6f6),
        scaffoldBackgroundColor: Color(0xFFf6f6f6),
      ),
      home: Test(),
    );
  }
}
