import 'package:e_store1/Admin/Add-Product.dart';
import 'package:e_store1/Admin/Admin_logion.dart';
import 'package:e_store1/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Order.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  void _addProduct() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                AddProduct())); // Adjust the route name as needed
  }

  void _deleiveryStatus() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                OrderReceived())); // Adjust the route name as needed
  }

  // Delete user account
  void _additem() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Admin Panel",
                  style: AppWidget.boldTextFieldStyle(),
                ),
                InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AdminLogin()));
                    },
                    child: Icon(
                      Icons.logout_outlined,
                      size: 30,
                    )),
              ],
            ),
            SizedBox(height: 30),
            _buildProfileOption(
              icon: Icons.add,
              title: "Add Product",
              value: ' ',
              onTap: _addProduct,
            ),
            SizedBox(height: 10),
            _buildProfileOption(
              icon: Icons.shopping_cart_outlined,
              title: "delivering Status",
              value: '',
              onTap: _deleiveryStatus,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String value,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(icon, size: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppWidget.boldTextFieldStyle(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
