import 'package:flutter/material.dart';
import 'resetPassword.dart';

class ResetPassAuthOTP extends StatefulWidget {
  @override
  _ResetPassAuthOTPState createState() => _ResetPassAuthOTPState();
}

class _ResetPassAuthOTPState extends State<ResetPassAuthOTP> {
  String oTP;

  final _formKey = GlobalKey<FormState>();
  final oTPCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.size.width * 0.05;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'OTP Authenticate',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(padding),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Icon(
                      Icons.vpn_key_outlined,
                      size: 100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please enter the OTP',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: oTPCon,
                    style: TextStyle(color: Colors.black),
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xfffbb313), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
                      ),
                      labelText: 'OTP',
                      labelStyle: TextStyle(color: Colors.black45),
                      hintText: 'OTP',
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          oTP = oTPCon.text;
                        }
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()),
                      );
                    },
                    child: Text(
                      'Authenticate',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
