import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/screens/record_screen.dart';
import 'package:laughie_app/screens/test.dart';
import 'package:uuid/uuid.dart';

class SignUpPrescription extends StatefulWidget {
  final UserCredential userCredential;
  SignUpPrescription({this.userCredential});
  @override
  _SignUpPrescriptionState createState() => _SignUpPrescriptionState();
}

class _SignUpPrescriptionState extends State<SignUpPrescription> {
  DateTime _startingDate, _endingDate;
  String _sessionValue;
  String _prescribedValue;
  String dayId = Uuid().v4();


//uploads details to firestore
  _uploadPrescriptionDetails() {
    FocusScope.of(context).unfocus();

    usersRef.doc(FirebaseAuth.instance.currentUser.uid).update({
      "starting_date": _startingDate,
      "ending_date": _endingDate,
      "sessions": int.parse(_sessionValue),
      "prescribed_by": _prescribedValue,
      "signup_status": 3,
    });


    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RecordScreen(),
        ),
        (route) => false);
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

    final padding = mediaQuery.size.width * 0.05;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    DateTime valid = DateTime.now();

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  height: screenHeight * 0.05,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      'Duration:',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xfffbb313), width: 2.0),
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Select the starting date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return value.isBefore(
                              DateTime.now().subtract(Duration(days: 1)))
                          ? 'You cannot start in the past!'
                          : null;
                    },
                    onDateSelected: (DateTime value) {
                      _startingDate = value;
                      print(value);
                      setState(() {
                        valid = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xfffbb313), width: 2.0),
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Select the last date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return value.isBefore(_startingDate)
                          ? 'You cannot end before you start!'
                          : null;
                    },
                    onDateSelected: (DateTime value) {
                      _endingDate = value;
                      print(value);
                    },
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Text(
                  '''How many number of sessions per day?                                  ''',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  height: screenHeight * 0.08,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton<String>(
                    value: _sessionValue,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 24,
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black),
                    underline: SizedBox(),
                    hint: Text('Number of sessions per day'),
                    onChanged: (newValue) {
                      setState(() {
                        _sessionValue = newValue;
                      });
                    },
                    items: <String>['1', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  height: screenHeight * 0.05,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      'Prescribed By?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  height: screenHeight * 0.08,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton<String>(
                    value: _prescribedValue,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 24,
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black),
                    underline: SizedBox(),
                    hint: Text('Prescribed by'),
                    onChanged: (newValue) {
                      setState(() {
                        _prescribedValue = newValue;
                      });
                    },
                    items: <String>['Self', 'Doctor', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  height: screenHeight * 0.08,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _uploadPrescriptionDetails,
                    child: Text(
                      'Finish',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xfffbb313),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
