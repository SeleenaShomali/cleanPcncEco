import 'package:flutter/material.dart';

class HomesearchBar extends StatelessWidget {
  const HomesearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.02),
                  ),
                ]),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search any Product...',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            );
  }
}