import 'package:flutter/material.dart';
import '../screens/userProfile.dart';
import '../screens/signUp.dart';

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
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.emoji_emotions_outlined,
                size: 36,
                color: Color(0xfffbb313),
                //this.id == HomeScreen.id ? Colors.white : Color(0xFFC3C2C3),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                    (route) => false);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.receipt_long,
                //FontAwesomeIcons.americanSignLanguageInterpreting,
                size: 35,
                color: Colors.black,
                // this.id == DifficultyPage.id
                //     ? Colors.white
                //     : Color(0xFFC3C2C3),
              ),
              // onPressed: () {

              // },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.assessment,
                size: 35,
                color: Colors.black,
                // this.id == ASLDetection.id
                //     ? Colors.white
                //     : Color(0xFFC3C2C3),
              ),
              // onPressed: () {
              // },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.person,
                size: 35,
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
    );
  }
}
