import 'package:flutter/material.dart';
import 'package:get/get.dart';

class title extends StatefulWidget {
  const title({super.key});

  @override
  State<title> createState() => _titleState();
}

class _titleState extends State<title> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'All Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(), // Automatically fills the space between the text and the button
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed('/AllCat');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 9),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }
}