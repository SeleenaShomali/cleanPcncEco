import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/presentation/controller/category_controller.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final CategoryController categoryController = Get.find();
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text(
          'Categories',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 124, 124, 125),
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Back to Home'),
              onTap: () {
                // Navigate back to home or any action needed
                Get.offAllNamed('home');
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
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
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search any Category...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey,),
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
          ),
          Expanded(
            child: Obx(() {
              if (categoryController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (categoryController.isError.value) {
                return const Center(child: Text('Failed to load categories'));
              } else {
                // Filter categories based on search text
                final filteredCategories = categoryController.categories.where(
                    (category) => category.name
                        .toLowerCase()
                        .contains(searchText.toLowerCase()));

                if (filteredCategories.isEmpty) {
                  return const Center(child: Text('No categories found'));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    childAspectRatio: 130 / 170, // Width to height ratio
                  ),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = filteredCategories.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                               
                              ),
                              child: AspectRatio(
                                aspectRatio: 1.40,
                                child: category.image != null &&
                                        category.image.isNotEmpty
                                    ? Image.network(
                                        category.image,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Icon(Icons.error_outline),
                                          );
                                        },
                                      )
                                    : Container(
                                        color: Colors.grey[200],
                                        child:const  Center(
                                          child:
                                              Icon(Icons.image_not_supported),
                                        ),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
