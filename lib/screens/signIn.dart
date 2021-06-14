import 'package:flutter/material.dart';
import 'signUp.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email, password;

  final _formKey = GlobalKey<FormState>();
  final emailCon = new TextEditingController();
  final passwordCon = new TextEditingController();

  bool visi1 = true;
  IconData i1 = Icons.visibility;
  IconData i2 = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfffbb313),
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
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
              TextFormField(
                obscureText: visi1,
                controller: passwordCon,
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
              TextButton(
                onPressed: () {
                  //navigateToSubPage(context);
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xfffbb313),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_formKey.currentState.validate()) {
                      email = emailCon.text;
                      password = passwordCon.text;
                    }
                  });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => SignUpPersonalDetails()),
                  // );
                },
                child: Text(
                  'Log In',
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
                  children: <Widget>[
                    Text('Don\'t have an account?'),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xfffbb313),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
