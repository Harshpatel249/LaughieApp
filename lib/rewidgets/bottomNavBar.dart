import 'package:flutter/material.dart';
import 'package:laughie_app/screens/homePage.dart';
import 'package:laughie_app/screens/prescriptionScreen.dart';
import 'package:laughie_app/screens/source_page.dart';

import '../screens/homePage.dart';
import '../screens/stats_page.dart';
import '../screens/userProfile.dart';

/*
* Bottom NavBar is the reusable widget used in most screens for navigation within the app
* It is dynamically sized using the media query
* */
class BottomNavBar extends StatefulWidget {
  String
      id; // Every page that calls the bottomNavBar is identified by it's id to represent the active page

  BottomNavBar({@required this.id});
  @override
  _BottomNavBarState createState() => _BottomNavBarState(id: this.id);
}

class _BottomNavBarState extends State<BottomNavBar> {
  String id;

  _BottomNavBarState({@required this.id});
  @override
  Widget build(BuildContext context) {
    final bottomBarHeight = MediaQuery.of(context).size.height * 0.08;
    return SizedBox(
      height: bottomBarHeight,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              icon: Icon(
                Icons.emoji_emotions_outlined,
                size: bottomBarHeight * 0.69,
                color:
                    this.id == HomePage.id ? Color(0xfffbb313) : Colors.black,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SourcePage()),
                    (route) => false);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.receipt_long,
                size: bottomBarHeight * 0.69,
                color: this.id == PrescriptionScreen.id
                    ? Color(0xfffbb313)
                    : Colors.black,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrescriptionScreen()),
                    (route) => false);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.assessment,
                size: bottomBarHeight * 0.69,
                color:
                    this.id == StatsPage.id ? Color(0xfffbb313) : Colors.black,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => StatsPage()),
                    (route) => false);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  size: bottomBarHeight * 0.69,
                  color: this.id == UserProfile.id
                      ? Color(0xfffbb313)
                      : Colors.black,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfile()),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
