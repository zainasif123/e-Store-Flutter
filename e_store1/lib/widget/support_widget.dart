import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold);
  }

  static TextStyle lightTextFieldStyle() {
    return TextStyle(
        color: Colors.black54, fontSize: 20.0, fontWeight: FontWeight.w500);
  }

  static TextStyle semiboldTextStyle() {
    return TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
  }
}
