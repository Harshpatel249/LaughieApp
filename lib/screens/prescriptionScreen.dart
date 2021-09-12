import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laughie_app/screens/prescriptionUpdate.dart';
import 'package:laughie_app/screens/test.dart';

import '../rewidgets/bottomNavBar.dart';
import '../rewidgets/circularProgressBar.dart';

class PrescriptionScreen extends StatefulWidget {
  static String id = 'prescription_screen';
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  var noSessions = 3;
  var startingDate = 'x/x/xx';
  var endingDate = 'x/x/xx';
  Timestamp _startingTimestamp;
  Timestamp _endingTimestamp;
  bool _isFetched = false;
  String prescribedBy = '';

  //fetches prescription details from firebase of a particular user
  _fetchDetails() async {
    DocumentSnapshot userSnapshot =
        await usersRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    _startingTimestamp = userSnapshot['starting_date'];
    _endingTimestamp = userSnapshot['ending_date'];
    noSessions = userSnapshot['sessions'];
    prescribedBy = userSnapshot['prescribed_by'];
    startingDate = "${DateFormat.yMMMd().format(_startingTimestamp.toDate())}";
    endingDate = "${DateFormat.yMMMd().format(_endingTimestamp.toDate())}";
    setState(() {
      _isFetched = true;
    });
  }

  @override
  void initState() {
    _fetchDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Prescription',
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
        bottomNavigationBar: BottomNavBar(id: PrescriptionScreen.id),
        body: _isFetched
            ? ListView(
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
                                  height: constraints.maxHeight * 0.1,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height:
                                                constraints.maxHeight * 0.092,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                'Starting Date',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black45),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height:
                                                constraints.maxHeight * 0.092,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                startingDate,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 25.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height:
                                                constraints.maxHeight * 0.092,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                'Ending date',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black45),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height:
                                                constraints.maxHeight * 0.092,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                endingDate,
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
                                  height: constraints.maxHeight * 0.1,
                                ),
                                Center(
                                  child: Container(
                                    height: constraints.maxHeight * 0.092,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Number of Session per day',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black45),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: constraints.maxHeight * 0.092,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        noSessions.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.08,
                                ),
                                Center(
                                  child: Container(
                                    height: constraints.maxHeight * 0.092,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Prescribed By',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black45),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: constraints.maxHeight * 0.092,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        prescribedBy,
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
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: padding, right: padding),
                        child: SizedBox(
                          height: screenHeight * 0.08,
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PrescriptionUpdate()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Update Prescription',
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
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                    ],
                  ),
                ],
              )
            : CircularProgressBar(),
      ),
    );
  }
}
