import 'package:flutter/material.dart';
import '../screens/userProfile.dart';
import '../screens/signIn.dart';
import '../screens/stats_page.dart';

class BottomNavBar extends StatefulWidget {
  String id;

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
                color: Color(0xfffbb313),
                //this.id == HomeScreen.id ? Colors.white : Color(0xFFC3C2C3),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                    (route) => false);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.receipt_long,
                //FontAwesomeIcons.americanSignLanguageInterpreting,
                size: bottomBarHeight * 0.69,
                color: Colors.black,
                // this.id == DifficultyPage.id
                //     ? Colors.white
                //     : Color(0xFFC3C2C3),
              ),
              // onPressed: () {

              // },
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
