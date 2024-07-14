// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dashboard/presentation/components/FullImage.dart';
import '../controller/category_controller.dart';

class CategoryList extends StatelessWidget {
  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (categoryController.isError.value) {
        return Center(child: Text('Failed to load categories'));
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categoryController.categories.map((category) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                    imageUrl: category.image.isNotEmpty
                                        ? category.image
                                        : '')));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300], // Placeholder color
                        radius: 30,
                        child: ClipOval(
                          child: category.image != null &&
                                  category.image.isNotEmpty
                              ? Hero(
                                  tag: category.id,
                                  child: Image.network(
                                    category.image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(Icons.image_not_supported,
                                            size: 30),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child:
                                      Icon(Icons.image_not_supported, size: 30),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      category.name,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }
    });
  }
}
