import 'package:flutter/material.dart';
import 'signUpPersonalDetails.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, userName, password, confirmPassword;

  final _formKey = GlobalKey<FormState>();
  final emailCon = new TextEditingController();
  final usernameCon = new TextEditingController();
  final passwordCon = new TextEditingController();
  final confirmPasswordCon = new TextEditingController();

  bool visi1 = true;
  bool visi2 = true;
  IconData i1 = Icons.visibility;
  IconData i2 = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SignUp',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Image.asset(
                  //   'assets/images/logo.png',
                  //   height: 130,
                  // ),
                  Center(
                    child: Container(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          'assets/images/nlogo_circle.png',
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
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      'Laughie',
                      style: TextStyle(
                        fontFamily: 'Pattaya',
                        fontSize: 40,
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
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: emailCon,
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
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: usernameCon,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.name,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xfffbb313), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
                      ),
                      labelText: 'UserName',
                      labelStyle: TextStyle(color: Colors.black45),
                      hintText: 'UserName',
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
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
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black45),
                      hintText: 'Password',
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
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          userName = usernameCon.text;
                          email = emailCon.text;
                          password = passwordCon.text;
                          confirmPassword = confirmPasswordCon.text;
                        }
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpPersonalDetails()),
                      );
                    },
                    child: Text(
                      'Signup',
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
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have Account?"),
                        TextButton(
                            style: TextButton.styleFrom(
                              primary: Color(0xfffbb313),
                            ),
                            onPressed: () {},
                            child: Text("Login"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
