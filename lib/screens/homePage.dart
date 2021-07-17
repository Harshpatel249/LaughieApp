import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/bottomNavBar.dart';
import 'package:laughie_app/screens/session_screen.dart';

class HomePage extends StatelessWidget {
  String id = 'home_page';
  final String mediaType;
  final String filePath;
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

    final bottomBarHeight = MediaQuery.of(context).size.height * 0.08;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        bottomBarHeight;

    final padding = mediaQuery.size.width * 0.05;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: BottomNavBar(),
        body: ListView(
          children: [
            Column(
              children: [
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
