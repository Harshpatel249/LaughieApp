import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/bottomNavBar.dart';
import 'package:laughie_app/rewidgets/video_widget.dart';
import 'package:laughie_app/screens/session_screen.dart';

/*
* This is landing screen for logged in users
* */

class HomePage extends StatelessWidget {
  static String id = 'home_page';
  final String mediaType; //For fetching the media type of recorded laughie
  final String filePath; //For fetching the location of the laughie
  HomePage({this.filePath, this.mediaType});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Home',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    //Storing the bottomnavbar height to subtract and get the usable free space on screen
    final bottomBarHeight = MediaQuery.of(context).size.height * 0.08;

    //Getting the usable free screen space for dynamic sizing
    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        bottomBarHeight;

    //Dynamic and fixed side padding
    final padding = mediaQuery.size.width * 0.05;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: BottomNavBar(
          id: HomePage.id,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: Container(
                    height: screenHeight * 0.06,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text('Welcome!!'),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SessionScreen(
                                    filePath: this.filePath,
                                    mediaType: this.mediaType,
                                  )),
                          (route) => false);
                    },
                    child: Container(
                      height: screenHeight * 0.15,
                      child: LayoutBuilder(
                        builder: (ctx, constraints) {
                          return CircleAvatar(
                            radius: constraints.maxHeight / 2,
                            backgroundImage: AssetImage(
                              'assets/images/nlogo_circle.png',
                            ),
                          );
                        },
                      ),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Center(
                  child: Container(
                    height: screenHeight * 0.08,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        'Laughie',
                        style: TextStyle(
                          fontFamily: 'Pattaya',
                          fontSize: 100,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(8.0, 3.0),
                              blurRadius: 10.0,
                              color: Color.fromARGB(69, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Text('Tap on the logo to start your session!'),
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text('How to go through the session?'),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: padding / 2, right: padding / 2),
                  child: Container(
                    height: screenHeight * 0.45,
                    child: VideoWidget(
                      //Tutorial video
                      screenHeight: screenHeight,
                      url:
                          "https://firebasestorage.googleapis.com/v0/b/laughie-52bd5.appspot.com/o/laugh_along.mp4?alt=media&token=9b7793f4-ca06-4829-b7e2-0af58809508e",
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
