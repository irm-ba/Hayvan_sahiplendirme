import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:pet_adoption/aboutpage.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/deneme_service.dart';
import 'package:pet_adoption/example.dart';
import 'package:pet_adoption/screens/IntroScreen.dart';
import 'package:pet_adoption/screens/home.dart';
import 'package:pet_adoption/sign_up.dart';
import 'package:pet_adoption/widgets/healtbutton.dart';
import 'firebase/auth.dart';
import 'package:pet_adoption/widgets/HealthRecordAdd.dart';
import 'package:flutter/services.dart'; // Import SystemChrome

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Felvera',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundColor,
          iconTheme: IconThemeData(color: kBrownColor),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: kBrownColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
