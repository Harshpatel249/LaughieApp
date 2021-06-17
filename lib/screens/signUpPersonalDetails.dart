import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:csc_picker/csc_picker.dart';
import 'signUpMedicalHistory.dart';

class SignUpPersonalDetails extends StatefulWidget {
  @override
  _SignUpPersonalDetailsState createState() => _SignUpPersonalDetailsState();
}

class _SignUpPersonalDetailsState extends State<SignUpPersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  final fullNameCon = new TextEditingController();
  final contactNumCon = new TextEditingController();

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  String professionValue = 'Student';
  String genderValue = 'Male';

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
                      child: TextField(
                        controller: fullNameCon,
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
                          hintText: 'FullName',
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
                        value: genderValue,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 24,
                        isExpanded: true,
                        style: const TextStyle(color: Colors.black),
                        underline: SizedBox(),
                        hint: Text('Gender'),
                        onChanged: (newValue) {
                          setState(() {
                            genderValue = newValue;
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
                      height: screenHeight * 0.10,
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
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) => (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null,
                        onDateSelected: (DateTime value) {
                          print(value);
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
                        value: professionValue,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 24,
                        isExpanded: true,
                        style: const TextStyle(color: Colors.black),
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          setState(() {
                            professionValue = newValue;
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
                      child: TextField(
                        controller: contactNumCon,
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
                          labelText: 'Contact Number',
                          labelStyle: TextStyle(color: Colors.black45),
                          hintText: 'Contact Number',
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
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            ///store value in state variable
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpMedicalHistory()),
                          );
                        },
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
