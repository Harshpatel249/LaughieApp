import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laughie_app/screens/signUpPersonalDetails.dart';
import 'package:laughie_app/screens/test.dart';

import 'signIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final usersRef = FirebaseFirestore.instance.collection('users');
  String _email, _userName, _password, _confirmPassword;
  bool _isLoading = false;
  UserCredential userCredential;
  final _formKey = GlobalKey<FormState>();
  // final emailCon = new TextEditingController();
  // final usernameCon = new TextEditingController();
  final passwordCon = new TextEditingController();
  // final confirmPasswordCon = new TextEditingController();

  bool visi1 = true;
  bool visi2 = true;
  IconData i1 = Icons.visibility;
  IconData i2 = Icons.visibility;

  //First, it will validate the fields, then it will create a new user using firebase Auth
  _trySignUp() async {
    FocusScope.of(context).unfocus();
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();


    }
    if (isValid) {
      try {
        setState(() {
          _isLoading = true;
        });
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        usersRef.doc(userCredential.user.uid).set({
          "email": _email,
          "username": _userName,
          "signup_status": 0,
          "has_recorded_laughie": false,
        });
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => SignUpPersonalDetails()),
        // );
      } on PlatformException catch (err) {
        var message = 'An error occured, please check your credentials!';

        if (err.message != null) {
          message = err.message;
        }
        SnackBar snackBar = SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (err) {
        var message;
        if (err.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (err.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        }
        SnackBar snackBar = SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignUpPersonalDetails(
                    userCredential: this.userCredential,
                  )),
        );
      }
    });
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

    return Scaffold(
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
                  children: <Widget>[
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
                      height: screenHeight * 0.03,
                    ),
                    Container(
                      height: screenHeight * 0.11,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          } else {
                            return null;
                          }
                        },

                        onSaved: (input) {
                          _email = input.trim();
                        },
                        // controller: emailCon,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xfffbb313), width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFC3C2C3), width: 2.0),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black45),
                          // hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.11,
                      child: TextFormField(
                        // controller: usernameCon,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'username cannot be empty';
                          } else if (value.length < 4) {
                            return 'username must be at least 4 characters long.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (input) {
                          _userName = input.trim();
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
                          labelText: 'UserName',
                          labelStyle: TextStyle(color: Colors.black45),
                          //hintText: 'UserName',
                          hintStyle: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.11,
                      child: TextFormField(
                        obscureText: visi1,
                        controller: passwordCon,
                        style: TextStyle(color: Colors.black),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length < 7) {
                            return 'Password must be at least 7 characters long.';
                          }
                          return null;
                        },
                        onSaved: (input) {
                          _password = input.trim();
                        },
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xfffbb313), width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFC3C2C3), width: 2.0),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black45),
                          //  hintText: 'Password',
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
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.11,
                      child: TextFormField(
                        obscureText: visi2,
                        // controller: confirmPasswordCon,
                        style: TextStyle(color: Colors.black),
                        validator: (String value) {
                          if (value != passwordCon.value.text) {
                            return 'Password do not match!';
                          }
                          return null;
                        },
                        onSaved: (input) {
                          _confirmPassword = input.trim();
                        },
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xfffbb313), width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFC3C2C3), width: 2.0),
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.black45),
                          //  hintText: 'Confirm Password',
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
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    if (_isLoading)
                      Center(
                        child: Container(
                          height: screenHeight * 0.07,
                          width: screenHeight * 0.07,
                          child: CircularProgressIndicator(
                            backgroundColor: Color(0xfffbb313),
                            valueColor: AlwaysStoppedAnimation(
                              Color(0xff222223),
                            ),
                          ),
                        ),
                      ),
                    if (!_isLoading)
                      Container(
                        height: screenHeight * 0.10,
                        child: ElevatedButton(
                          onPressed: _trySignUp,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'Signup',
                              style: TextStyle(fontSize: 20),
                            ),
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
                    if (!_isLoading)
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already have Account?"),
                            TextButton(
                                style: TextButton.styleFrom(
                                  primary: Color(0xfffbb313),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignIn(),
                                    ),
                                  );
                                },
                                child: Text("Login"))
                          ],
                        ),
                      )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
