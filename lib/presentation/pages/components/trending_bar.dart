
import 'package:flutter/material.dart';

class TrendingProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1.0, // Adjust the opacity value here if needed
      child: Container(
        width: 200.0,
        height: 60.0,
        decoration: const BoxDecoration(
          color: Color(0xFFF2673A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
         
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                 
                  SizedBox(width: 8.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trending Products',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                           Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5,),
                  
                          Text(
                            'Last Date 29/02/22',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(13),
                child: ElevatedButton(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  style: ElevatedButton.styleFrom(
                    
                    foregroundColor: Color(0xFFF2673A), backgroundColor: Color((0xFFF2673A)),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'View all',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}