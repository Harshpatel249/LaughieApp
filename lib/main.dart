import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laughie_app/screens/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Color(0xfffbb313),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        primaryColor: Color(0xfffbb313),
        colorScheme: ColorScheme.fromSwatch(
                // primarySwatch: Colors.orange,
                )
            .copyWith(
          primary: Color(0xfffbb313),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        bottomAppBarColor: Color(0xFFf6f6f6),
        scaffoldBackgroundColor: Color(0xFFf6f6f6),
        errorColor: Color(0xffe03d2c),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
          subtitle1: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      home: Test(),

      // StreamBuilder(
      //
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, userSnapshot) {
      //     if (userSnapshot.hasData) {
      //       return SignUpPersonalDetails();
      //     }
      //     return SignIn();
      //   },
      // ),
      //Test()
    );
  }
}
// Navigator.push(
//   context,
//   MaterialPageRoute(
//       builder: (context) => SignUpPersonalDetails()),
// );
