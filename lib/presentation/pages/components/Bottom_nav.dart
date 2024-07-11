// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(

          icon: SizedBox(
            height: 22,
            width: 20,
            child: Image.asset('assets/images/Hvector.png')),
          label: 'Home' ,
          
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.black,
          ),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(null),
          label: '', // No label for middle item
        ),
        BottomNavigationBarItem(
          icon: Icon(null),
          label: '', // No label for middle item
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings_outlined,
            color: Colors.black,
          ),
          label: 'Setting',
        ),
      ],
    );
  }
}
