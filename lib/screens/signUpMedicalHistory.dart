import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'signUpPrescription.dart';

class SignUpMedicalHistory extends StatefulWidget {
  final UserCredential userCredential;
  SignUpMedicalHistory({this.userCredential});
  @override
  _SignUpMedicalHistoryState createState() => _SignUpMedicalHistoryState();
}

enum Diseases { do_have, do_not_have }
enum COVID { Yes, No }

class _SignUpMedicalHistoryState extends State<SignUpMedicalHistory> {
  Diseases _diseases = Diseases.do_not_have;
  COVID _covid = COVID.No;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical History',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you suffering from any  of the below medical problems?',
                style: TextStyle(fontSize: 20),
              ),
              Text('''
                  
        1) Breathing/Respiration disease
               
        2) Heart disease
               
        3) Diabetes disease
               
        4) Blood disease
               
        5) Other disease
                ''', style: TextStyle(fontSize: 15, color: Colors.black)),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  'I do not have any of these conditions',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
                ),
                leading: Radio(
                  value: Diseases.do_not_have,
                  groupValue: _diseases,
                  onChanged: (Diseases value) {
                    setState(() {
                      _diseases = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'I do have a condition',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
                ),
                leading: Radio(
                  value: Diseases.do_have,
                  groupValue: _diseases,
                  onChanged: (Diseases value) {
                    setState(() {
                      _diseases = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Have you have COVID-19?                          ',
                  style: TextStyle(fontSize: 20), textAlign: TextAlign.left),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: const Text(
                  'I do not have any of these conditions',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
                ),
                leading: Radio(
                  value: COVID.Yes,
                  groupValue: _covid,
                  onChanged: (COVID value) {
                    setState(() {
                      _covid = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'I do have a condition',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
                ),
                leading: Radio(
                  value: COVID.No,
                  groupValue: _covid,
                  onChanged: (COVID value) {
                    setState(() {
                      _covid = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPrescription(
                          userCredential: widget.userCredential,
                        ),
                      ),
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
                        borderRadius: BorderRadius.circular(8), // <-- Radius
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
