import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  bool _nameValid = true;
  bool _usernameValid = true;
  bool _emailValid = true;
  bool _contactValid = true;

  final String userProfession = 'Student';
  String professionValue = 'Student';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Edit Profile',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );

    final padding = mediaQuery.size.width * 0.05;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    Column buildNameField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: Container(
              height: screenHeight * 0.04,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text("Name"),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.10,
            child: TextField(
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
            ),
          ),
        ],
      );
    }

    Column buildUserNameField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: Container(
              height: screenHeight * 0.04,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text("Username"),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.10,
            child: TextField(
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
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: Container(
              height: screenHeight * 0.04,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text("Email"),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.10,
            child: TextField(
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
            ),
          )
        ],
      );
    }

    Column buildContactField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: Container(
              height: screenHeight * 0.04,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text("Contact Number"),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.10,
            child: TextField(
              controller: contactController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffbb313), width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
                ),
                hintText: "Contact Number",
                errorText: _contactValid ? null : "Contact cannot be empty",
              ),
            ),
          ),
        ],
      );
    }

    Column buildProfessionField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: Container(
              height: screenHeight * 0.04,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text("Profession"),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.10,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
              items: <String>['Student', 'Researcher', 'Professor', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      );
    }

    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: appBar,
          body: ListView(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          buildNameField(),
                          buildUserNameField(),
                          buildEmailField(),
                          buildContactField(),
                          buildProfessionField(),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.08,
                        child: TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
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
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
