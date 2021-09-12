import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/test.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

// To allow user to change his details
class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  bool _nameValid = true;
  bool _usernameValid = true;
  bool _emailValid = true;
  bool _contactValid = true;
  bool _isFetched = false;
  bool _isLoading = false;
  final String userProfession = 'Student';
  String _professionValue = 'Student';

  updateUserData() {
    FocusScope.of(context).unfocus();
    setState(() {
      _nameController.text.isEmpty ? _nameValid = false : _nameValid = true;
      (_userNameController.text.isEmpty || _userNameController.text.length < 4)
          ? _usernameValid = false
          : _usernameValid = true;
      (_emailController.text.isEmpty || _userNameController.text.contains("@"))
          ? _emailValid = false
          : _emailValid = true;
      (_contactController.text.isEmpty || _contactController.text.length != 10)
          ? _contactValid = false
          : _contactValid = true;
    });

    if (_nameValid && _usernameValid && _emailValid && _contactValid) {
      setState(() {
        _isLoading = true;
      });
      var message = "profile updated successfully";
      try {
        usersRef.doc(FirebaseAuth.instance.currentUser.uid).update({
          "name": _nameController.text,
          "username": _userNameController.text,
          "email": _emailController.text,
          "contact_number": _contactController.text,
          "profession": _professionValue,
        });
        FirebaseAuth.instance.currentUser //user _auth.currentUser instead
            .updateEmail(_emailController.text)
            .then(
          (value) {
            message = 'email updated successfully';
          },
        ).catchError((onError) {
          message = onError.toString();
        });
      } on FirebaseAuthException catch (err) {
        if (err.message != null) {
          message = err.message;
        }
      } on FirebaseException catch (err) {
        if (err.message != null) {
          message = err.message;
        }
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

  _fetchDetails() async {
    DocumentSnapshot data =
        await usersRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    _nameController.text = data['name'];
    _userNameController.text = data['username'];
    _emailController.text = data['email'];
    _contactController.text = data['contact_number'];
    _professionValue = data['profession'];
    setState(() {
      _isFetched = true;
    });
  }

  @override
  void initState() {
    _fetchDetails();
    super.initState();
  }

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
              controller: _nameController,
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
              controller: _userNameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffbb313), width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
                ),
                hintText: "UserName",
                errorText: _usernameValid
                    ? null
                    : "username must be at least 4 characters long.",
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
              controller: _emailController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffbb313), width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
                ),
                hintText: "Email",
                errorText:
                    _emailValid ? null : "Please enter a valid email address",
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
              controller: _contactController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffbb313), width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC3C2C3), width: 2.0),
                ),
                hintText: "Contact Number",
                errorText: _contactValid
                    ? null
                    : "Contact Number does not contain 10 digits",
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
              value: _professionValue,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              iconSize: 24,
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
              underline: SizedBox(),
              onChanged: (newValue) {
                setState(() {
                  _professionValue = newValue;
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

    return _isFetched
        ? Container(
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
                            _isLoading
                                ? CircularProgressBar()
                                : Container(
                                    width: double.infinity,
                                    height: screenHeight * 0.08,
                                    child: TextButton(
                                      onPressed: updateUserData,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: Text(
                                          'Update Profile',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
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
          )
        : CircularProgressBar();
  }
}
