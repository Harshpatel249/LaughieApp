import 'package:flutter/material.dart';
import 'signIn.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String password, confirmPassword;

  final _formKey = GlobalKey<FormState>();
  final passwordCon = new TextEditingController();
  final confirmPasswordCon = new TextEditingController();

  bool visi1 = true;
  bool visi2 = true;
  IconData i1 = Icons.visibility;
  IconData i2 = Icons.visibility;

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
                    'Please enter the new password',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: visi1,
                    controller: passwordCon,
                    style: TextStyle(color: Colors.black),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 6) {
                        return 'Password too small';
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xfffbb313), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
                      ),
                      labelText: 'New Password',
                      labelStyle: TextStyle(color: Colors.black45),
                      hintText: 'New Password',
                      hintStyle: TextStyle(color: Colors.black45),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visi1 = !visi1;
                            if (visi1)
                              i1 = Icons.visibility;
                            else
                              i1 = Icons.visibility_off;
                          });
                        },
                        child: Icon(
                          i1,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: visi2,
                    controller: confirmPasswordCon,
                    style: TextStyle(color: Colors.black),
                    validator: (String value) {
                      if (value != passwordCon.value.text) {
                        return 'Password do not match!';
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xfffbb313), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
                      ),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.black45),
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.black45),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visi2 = !visi2;
                            if (visi2)
                              i2 = Icons.visibility;
                            else
                              i2 = Icons.visibility_off;
                          });
                        },
                        child: Icon(
                          i2,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          password = passwordCon.text;
                          confirmPassword = confirmPasswordCon.text;
                        }
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Text(
                      'Reset',
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
