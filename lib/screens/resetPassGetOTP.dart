import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/screens/signIn.dart';

class ResetPassGetOTP extends StatefulWidget {
  @override
  _ResetPassGetOTPState createState() => _ResetPassGetOTPState();
}

class _ResetPassGetOTPState extends State<ResetPassGetOTP> {
  String _emailPhone;

  final _formKey = GlobalKey<FormState>();
  final emailPhoneCon = new TextEditingController();

  // sends an email which contains a link to reset the user password.
  _sendRequest() {
    setState(() {
      if (_formKey.currentState.validate()) {
        _emailPhone = emailPhoneCon.text;
      }
    });
    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailPhone)
          .whenComplete(() {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Alert',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Password reset link has been sent to ${emailPhoneCon.text}. Please check your inbox.',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                      (route) => false);
                },
              ),
            ],
          ),
        );
      });
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.size.width * 0.05;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Reset Password',
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
                    'Please enter your registered Email address',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailPhoneCon,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xfffbb313), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black45),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: _sendRequest,
                    child: Text(
                      'Send Request',
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
