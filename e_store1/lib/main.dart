import 'dart:io';

import 'package:e_store1/Admin/Admin_logion.dart';
import 'package:e_store1/Admin/Order.dart';
import 'package:e_store1/pages/bottomnav.dart';
import 'package:e_store1/pages/home.dart';
import 'package:e_store1/pages/login.dart';
import 'package:e_store1/pages/onboarding.dart';
import 'package:e_store1/pages/splash_screen.dart';
import 'package:e_store1/services/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io' as Platform;

void main() async {
  //Stripe.publishableKey = publisableKey;
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  if (Firebase.apps.isEmpty) {
    if (Platform.Platform.isAndroid || Platform.Platform.isIOS) {
      await Firebase.initializeApp(
          options: Platform.Platform.isAndroid
              ? const FirebaseOptions(
                  apiKey: 'AIzaSyBPzZK8zwO9aVNSkF0tM0AvBFEREK1Y6TQ',
                  appId: '1:806446548062:android:59f74224cd69b5dff060cf',
                  messagingSenderId: '806446548062',
                  projectId: 'e-store1-fe64e',
                  storageBucket: 'e-store1-fe64e.appspot.com')
              : const FirebaseOptions(
                  apiKey: 'AIzaSyBPzZK8zwO9aVNSkF0tM0AvBFEREK1Y6TQ',
                  appId: '1:806446548062:android:59f74224cd69b5dff060cf',
                  messagingSenderId: '806446548062',
                  projectId: 'e-store1-fe64e',
                  storageBucket: 'e-store1-fe64e.appspot.com'));
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'e_store',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AdminLogin(),
    );
  }
}
