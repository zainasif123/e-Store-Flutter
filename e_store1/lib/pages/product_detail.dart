import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store1/pages/Order.dart';
import 'package:e_store1/pages/bottomnav.dart';
import 'package:e_store1/services/SharedPreferance.dart';
import 'package:e_store1/widget/support_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  String name, price, description, image;
  ProductDetail({
    Key? key,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isLoading = false;

  Future<void> _placeOrder() async {
    setState(() {
      _isLoading = true;
    });
    String? username = await SaveUserDataLocal().getSaveUserName();
    String? userid = await SaveUserDataLocal().getSaveUserID();
    String? email = await SaveUserDataLocal()
        .getSaveUserEmail(); // Assuming you save user's email in SharedPreferences

    // Create order data
    Map<String, dynamic> orderData = {
      'productname': widget.name,
      'image': widget.image,
      'email': email,
      'name': username,
      'userid': userid,
      'price': widget.price,
      'status': 'On the way'
    };

    // Save order to Firestore
    await FirebaseFirestore.instance.collection('Orders').add(orderData);

    setState(() {
      _isLoading = false;
    });

    // Show a success message or navigate to another screen
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Order Placed Successfully",
        style: TextStyle(fontSize: 20),
      ),
    ));

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => BottomNav()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecefe8),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.arrow_back_ios_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Image.network(
                        widget.image,
                        height: 400,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.name,
                              style: AppWidget.boldTextFieldStyle(),
                            ),
                            Text(
                              "\$${widget.price.toString()}",
                              style: TextStyle(
                                  color: Color(0xFFfd6f3e),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Details",
                          style: AppWidget.semiboldTextStyle(),
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 16.0,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: _placeOrder,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xFFfd6f3e),
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
