import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store1/pages/login.dart';
import 'package:e_store1/services/SharedPreferance.dart';
import 'package:e_store1/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name, email, image;

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          name = userDoc['Name'];
          email = userDoc['Email'];
          image = userDoc['Image'];
        });
      } else {
        print('User document does not exist');
        // Handle the case where the user document does not exist
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Logout user
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    SaveUserDataLocal().clearAllData();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                Login())); // Adjust the route name as needed
  }

  // Delete user account
  void _deleteAccount() async {
    User? user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();
        await user.delete();

        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    Login())); // Adjust the route name as needed
      } catch (e) {
        print("Error deleting account: $e");
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Profile",
                      style: AppWidget.boldTextFieldStyle(),
                    ),
                  ),
                  if (image != null)
                    Center(
                      child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            GestureDetector(
                              onTap: () {
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFfd6f3e),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                        "Update Profile Picture",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(image!),
                                radius: 50,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.edit),
                            ),
                          ]),
                    ),
                  SizedBox(height: 16),
                  _buildProfileOption(
                    icon: Icons.person_2_outlined,
                    title: "Name",
                    value: name!,
                  ),
                  SizedBox(height: 10),
                  _buildProfileOption(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: email!,
                  ),
                  SizedBox(height: 10),
                  _buildProfileOption(
                    icon: Icons.logout_outlined,
                    title: "Logout",
                    value: 'Sure about logout? ',
                    onTap: _logout,
                  ),
                  SizedBox(height: 10),
                  _buildProfileOption(
                    icon: Icons.delete_outline,
                    title: "Delete Account",
                    value: 'Sure about delete account?',
                    onTap: _deleteAccount,
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
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppWidget.lightTextFieldStyle(),
                        ),
                      ),
                      Text(
                        value,
                        style: AppWidget.semiboldTextStyle(),
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
