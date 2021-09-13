import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:laughie_app/rewidgets/circularProgressBar.dart';
import 'package:laughie_app/screens/signIn.dart';
import 'package:laughie_app/screens/test.dart';
import 'package:path_provider/path_provider.dart';

import '../rewidgets/bottomNavBar.dart';
import 'editProfile.dart';

class UserProfile extends StatefulWidget {
  static String id = 'user_profile';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userName = 'UserName';
  String fullName = 'Ozzy Osbourne';
  String countryName = 'England';
  String userEmail = 'ozzycrazysobourne@gmail.com';
  String userProfession = 'Student';
  String userContact = '9494264669';
  String userDob = '24/09/2000';
  Timestamp _doB;
  bool _isFetched = false;
  File profilePictureFile;
  bool _isUploading = false;
  String photoUrl;

  // Fetches user details from the firestore.
  _fetchDetails() async {
    DocumentSnapshot userSnapshot =
        await usersRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    userName = userSnapshot['username'];
    fullName = userSnapshot['name'];
    countryName = userSnapshot['country'];
    userEmail = userSnapshot['email'];
    userProfession = userSnapshot['profession'];
    userContact = userSnapshot['contact_number'];
    _doB = userSnapshot['date_of_birth'];
    userDob = "${DateFormat.yMMMd().format(_doB.toDate())}";
    photoUrl = userSnapshot['profile_picture'];

    setState(() {
      _isFetched = true;
    });
  }

  @override
  void initState() {
    _fetchDetails();
    super.initState();
  }

  Future<File> pickCameraMedia(BuildContext context) async {
    final media = await ImagePicker().getImage(source: ImageSource.gallery);
    final file = File(media.path);
    return file;
  }

  Future _getProfilePhoto(BuildContext context) async {
    final profilePhoto = await pickCameraMedia(context);
    if (profilePhoto == null) {
      return;
    } else {
      setState(() {
        profilePictureFile = profilePhoto;
      });
    }
    _handleSubmit();
  }
// uploads user's selected image to firebase Storage
  Future<String> _uploadProfilePicture(File imageFile) async {
    TaskSnapshot taskSnapshot;

    try {
      UploadTask uploadTask = storageRef
          .child("${FirebaseAuth.instance.currentUser.uid}.jpg")
          .putFile(imageFile);
      taskSnapshot = uploadTask.snapshot;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (err) {
      if (err.code == "404") {
      }
    }
  }
// saves the upload image url to firestore
  updateFieldInFirestore(String url) {
    setState(() {
      photoUrl = url;
    });
    try {
      usersRef.doc(FirebaseAuth.instance.currentUser.uid).update({
        "profile_picture": url,
      }).then((value) {
        setState(() {
          _isUploading = false;
          // profilePictureFile = null;
        });
      });
    } on FirebaseException catch (err) {
    }
  }
//uploading selected image to firebase storage and saving its url to that particular user
  _handleSubmit() async {
    setState(() {
      _isUploading = true;
    });
    await _compressImage();
    String url = await _uploadProfilePicture(profilePictureFile);
    updateFieldInFirestore(url);
  }

  // to compress the image
  _compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(profilePictureFile.readAsBytesSync());
    //TODO: you can set the quality from anywhere between 0 to 100
    final compressedImageFile =
        File('$path/${FirebaseAuth.instance.currentUser.uid}.jpg')
          ..writeAsBytesSync(
            Im.encodeJpg(
              imageFile,
              quality: 95,
            ),
          );
    setState(() {
      profilePictureFile = compressedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        userName,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      actions: [
        DropdownButton(
          icon: Icon(
            Icons.more_vert,
            color: Color(0xff222223),
          ),
          items: [
            DropdownMenuItem(
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              value: 'logout',
            ),
          ],
          onChanged: (itemIdentifier) {
            if (itemIdentifier == 'logout') {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                  (route) => false);
            }
          },
        ),
      ],
    );

    final bottomBarHeight = MediaQuery.of(context).size.height * 0.08;

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        bottomBarHeight;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: BottomNavBar(id: UserProfile.id),
        body: _isFetched
            ? _isUploading
                ? CircularProgressBar()
                : ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                            height: screenHeight * 0.04,
                          ),
                          Container(
                            width: mediaQuery.size.width * 0.90,
                            height: screenHeight * 0.54,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(8, 10),
                                  blurRadius: 10.0,
                                  color: Color.fromARGB(50, 0, 0, 0),
                                ),
                              ],
                            ),
                            child: LayoutBuilder(
                              builder: (ctx, constraints) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: constraints.maxHeight * 0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: constraints.maxHeight * 0.20,
                                          child: CircleAvatar(
                                            radius:
                                                (constraints.maxHeight * 0.20) /
                                                    2,
                                            backgroundImage: photoUrl == null
                                                ? AssetImage(
                                                    'assets/images/profile.png',
                                                  )
                                                : NetworkImage(photoUrl),
                                          ),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: new Border.all(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  constraints.maxHeight * 0.14),
                                          child: GestureDetector(
                                            onTap: () {
                                              _getProfilePhoto(context);
                                            },
                                            child: Container(
                                              height:
                                                  constraints.maxHeight * 0.05,
                                              child: Icon(
                                                Icons.edit,
                                                size: constraints.maxHeight *
                                                    0.05,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.03,
                                    ),
                                    Center(
                                      child: Container(
                                        height: constraints.maxHeight * 0.092,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            fullName,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: Container(
                                        height: constraints.maxHeight * 0.092,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Email',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black45),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0, right: 15.0),
                                      child: Container(
                                        height: constraints.maxHeight * 0.092,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            userEmail,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: constraints.maxHeight *
                                                    0.092,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    'DoB',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black45),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: constraints.maxHeight *
                                                    0.092,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    userDob,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight *
                                                    0.03,
                                              ),
                                              Container(
                                                height: constraints.maxHeight *
                                                    0.092,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    'Country',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black45),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: constraints.maxHeight *
                                                    0.092,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    countryName,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: constraints.maxHeight *
                                                    0.092,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    'Profession',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black45),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: constraints.maxHeight *
                                                    0.092,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    userProfession,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight *
                                                    0.03,
                                              ),
                                              Container(
                                                height: constraints.maxHeight *
                                                    0.092,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    'Number',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black45),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: constraints.maxHeight *
                                                    0.092,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    userContact,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.03,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          SizedBox(
                            height: screenHeight * 0.08,
                            width: mediaQuery.size.width * 0.40,
                            child: TextButton(
                              onPressed: _isUploading
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditProfile(),
                                        ),
                                      );
                                    },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
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
                            height: screenHeight * 0.03,
                          ),
                        ],
                      ),
                    ],
                  )
            : CircularProgressBar(),
      ),
    );
  }
}
