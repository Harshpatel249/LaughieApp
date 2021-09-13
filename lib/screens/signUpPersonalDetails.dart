import 'package:csc_picker/csc_picker.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/screens/test.dart';

import 'signUpMedicalHistory.dart';

class SignUpPersonalDetails extends StatefulWidget {
  final UserCredential userCredential;
  SignUpPersonalDetails({this.userCredential});
  @override
  _SignUpPersonalDetailsState createState() => _SignUpPersonalDetailsState();
}

class _SignUpPersonalDetailsState extends State<SignUpPersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  final fullNameCon = new TextEditingController();
  final contactNumCon = new TextEditingController();

  String _fullName;
  DateTime _birthday;
  String _phoneNumber;
  String _countryValue = "";
  String _stateValue = "";
  String _cityValue = "";
  String address = "";

  String _professionValue = 'Student';
  String _genderValue = 'Male';

  // validates the fields and then upload the details in firestore.
  _submitDetails() {
    FocusScope.of(context).unfocus();
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
    }
    if (isValid) {
      usersRef.doc(FirebaseAuth.instance.currentUser.uid).update({
        "name": _fullName,
        "gender": _genderValue,
        "date_of_birth": _birthday,
        "profession": _professionValue,
        "contact_number": _phoneNumber,
        "country": _countryValue,
        "state": _stateValue,
        "city": _cityValue,
        "signup_status": 1,
        "profile_picture": "noUrl",
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpMedicalHistory(
            userCredential: widget.userCredential,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Sign Up',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    final padding = mediaQuery.size.width * 0.05;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      'Personal Details',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.10,
                      child: TextFormField(
                        // controller: fullNameCon,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (input) {
                          _fullName = input;
                        },
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.name,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xfffbb313), width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFC3C2C3), width: 2.0),
                          ),
                          labelText: 'FullName',
                          labelStyle: TextStyle(color: Colors.black45),
                          // hintText: 'FullName',
                          hintStyle: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.10,
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<String>(
                        value: _genderValue,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 24,
                        isExpanded: true,
                        style: const TextStyle(color: Colors.black),
                        underline: SizedBox(),
                        hint: Text('Gender'),
                        onChanged: (newValue) {
                          setState(() {
                            _genderValue = newValue;
                          });
                        },
                        items: <String>['Female', 'Male', 'Other']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      child: DateTimeFormField(
                        ///Add date validation and color theme correction
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.black45),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xfffbb313), width: 2.0),
                          ),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Date of Birth',
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value.isAfter(
                                  DateTime.now().subtract(Duration(days: 6570)))
                              ? 'You should be atleast 18 years old!'
                              : null;
                        },
                        onDateSelected: (DateTime value) {
                          _birthday = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.10,
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<String>(
                        value: _professionValue,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 24,
                        isExpanded: true,
                        style: const TextStyle(color: Colors.black),
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          setState(() {
                            _professionValue = newValue;
                          });
                        },
                        items: <String>[
                          'Student',
                          'Researcher',
                          'Professor',
                          'Other'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.10,
                      child: TextFormField(
                        // controller: contactNumCon,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Contact Number cannot be empty';
                          } else if (value.length != 10) {
                            return 'Contact Number does not contain 10 digits';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (input) {
                          _phoneNumber = input;
                        },
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xfffbb313), width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFC3C2C3), width: 2.0),
                          ),
                          labelText: 'Contact Number',
                          labelStyle: TextStyle(color: Colors.black45),
                          // hintText: 'Contact Number',
                          hintStyle: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.20,
                      child: CSCPicker(
                        showCities: true,
                        showStates: true,
                        flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.black45),
                        ),
                        disabledDropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.black45),
                        ),
                        selectedItemStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        dropdownHeadingStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),

                        ///DropdownDialog Item style [OPTIONAL PARAMETER]
                        dropdownItemStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),

                        ///Dialog box radius [OPTIONAL PARAMETER]
                        dropdownDialogRadius: 10.0,

                        ///Search bar radius [OPTIONAL PARAMETER]
                        searchBarRadius: 10.0,

                        ///Default Country [OPTIONAL PARAMETER]
                        defaultCountry: DefaultCountry.India,

                        ///triggers once country selected in dropdown
                        onCountryChanged: (value) {
                          setState(() {
                            ///store value in country variable
                            _countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            ///store value in state variable
                            _stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            _cityValue = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.08,
                      child: ElevatedButton(
                        onPressed: _submitDetails,
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xfffbb313),
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30)),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
