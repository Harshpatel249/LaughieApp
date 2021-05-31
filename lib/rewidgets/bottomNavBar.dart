import 'package:flutter/material.dart';

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
                Icons.home,
                size: 36,
                color: Colors.white,
                //this.id == HomeScreen.id ? Colors.white : Color(0xFFC3C2C3),
              ),
              // onPressed: () {
              // },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.menu_book,
                //FontAwesomeIcons.americanSignLanguageInterpreting,
                size: 35,
                color: Colors.white,
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
                Icons.camera_alt,
                size: 35,
                color: Colors.white,
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
                Icons.group,
                size: 35,
                color: Colors.white,
                // this.id == CommunityPage.id
                //     ? Colors.white
                //     : Color(0xFFC3C2C3),
              ),
              // onPressed: () {
              //
              // },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.account_circle,
                size: 35,
                color: Colors.white,
                // this.id == UserProfile.id
                //     ? Colors.white
                //     : Color(0xFFC3C2C3),
              ),
              // onPressed: () {
              //
              // },
            ),
          ),
        ],
      ),
    );
  }
}
