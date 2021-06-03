import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _nameValid = true;
  bool _usernameValid = true;
  bool _emailValid = true;

  Column buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text("Name"),
        ),
        TextField(
          controller: nameController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xfffbb313), width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
            ),
            hintText: "Name",
            errorText: _nameValid ? null : "name cannot be empty",
          ),
        )
      ],
    );
  }

  Column buildUserNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text("Username"),
        ),
        TextField(
          controller: userNameController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xfffbb313), width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
            ),
            hintText: "UserName",
            errorText: _usernameValid ? null : "username cannot be empty",
          ),
        )
      ],
    );
  }

  Column buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text("Email"),
        ),
        TextField(
          controller: emailController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xfffbb313), width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
            ),
            hintText: "Email",
            errorText: _emailValid ? null : "Email cannot be empty",
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          buildNameField(),
                          buildUserNameField(),
                          buildEmailField(),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xfffbb313),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
