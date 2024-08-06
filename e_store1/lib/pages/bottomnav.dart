import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_store1/pages/Order.dart';
import 'package:e_store1/pages/Profile.dart';
import 'package:e_store1/pages/home.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late Home homepage;
  late CurrentOrder order;
  late Profile profile;
  int _pageIndex =
      0; // Add this variable to keep track of the current page index

  @override
  void initState() {
    super.initState();
    homepage = Home();
    order = CurrentOrder();
    profile = Profile();
    pages = [homepage, order, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex], // Update the body to show the current page
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xffecefe8),
        color: Colors.black,
        animationDuration:
            Duration(milliseconds: 500), // Changed to milliseconds
        onTap: (int index) {
          setState(() {
            _pageIndex = index; // Update the index when an item is tapped
          });
        },
        items: [
          Icon(
            Icons.home_max_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_2_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
