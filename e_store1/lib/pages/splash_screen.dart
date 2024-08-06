import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_store1/pages/Sign_Up.dart';
import 'package:e_store1/pages/bottomnav.dart';
import 'package:e_store1/services/SharedPreferance.dart';
import 'package:e_store1/pages/login.dart';
import 'package:e_store1/pages/onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    bool? hasSeenOnboarding = await SaveUserDataLocal().getOnboardingStatus();

    if (hasSeenOnboarding == null || !hasSeenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Onboarding()),
      );
    } else {
      String? email = await SaveUserDataLocal().getSaveUserEmail();
      String? password = await SaveUserDataLocal().getSaveUserPassword();

      if (email != null && password != null) {
        try {
          await _auth.signInWithEmailAndPassword(
              email: email, password: password);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
          );
        } catch (e) {
          print("Error: $e");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Login()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => SignUp()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
