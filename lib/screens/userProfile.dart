import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../rewidgets/bottomNavBar.dart';
import 'editProfile.dart';

class UserProfile extends StatelessWidget {
  static String id = 'user_profile';
  final String userName = 'UserName';
  final String fullName = 'Ozzy Osbourne';
  final String countryName = 'England';
  final String userEmail = 'ozzycrazysobourne@gmail.com';
  final String userProfession = 'Student';
  final String userContact = '9494264669';
  final String userDob = '24/09/2000';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        userName,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    final bottomBarHeight = MediaQuery.of(context).size.height * 0.08;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        bottomBarHeight;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: BottomNavBar(id: UserProfile.id),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Center(
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
                SizedBox(
                  height: screenHeight * 0.03,
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
                  height: screenHeight * 0.03,
                ),
                Container(
                  width: mediaQuery.size.width * 0.90,
                  height: screenHeight * 0.54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(8, 10),
                        blurRadius: 10.0,
                        color: Color.fromARGB(50, 0, 0, 0),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                          Center(
                            child: Container(
                              height: constraints.maxHeight * 0.20,
                              child: CircleAvatar(
                                radius: (constraints.maxHeight * 0.20) / 2,
                                backgroundImage: AssetImage(
                                  'assets/images/profile.png',
                                ),
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
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                          Center(
                            child: Container(
                              height: constraints.maxHeight * 0.092,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  fullName,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Container(
                              height: constraints.maxHeight * 0.092,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black45),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Container(
                              height: constraints.maxHeight * 0.092,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  userEmail,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: constraints.maxHeight * 0.092,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'DoB',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black45),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: constraints.maxHeight * 0.092,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          userDob,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.03,
                                    ),
                                    Container(
                                      height: constraints.maxHeight * 0.092,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Country',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black45),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: constraints.maxHeight * 0.092,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          countryName,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: constraints.maxHeight * 0.092,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Profession',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black45),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: constraints.maxHeight * 0.092,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          userProfession,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.03,
                                    ),
                                    Container(
                                      height: constraints.maxHeight * 0.092,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Number',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black45),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: constraints.maxHeight * 0.092,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          userContact,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                SizedBox(
                  height: screenHeight * 0.08,
                  width: mediaQuery.size.width * 0.40,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xfffbb313),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
