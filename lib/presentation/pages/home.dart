import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/Data/repository/logoutRepository.dart';
import 'package:pcnc_ecommerce/Domain/usecases/logout_usecase.dart';
import 'package:pcnc_ecommerce/presentation/controller/category_controller.dart';
import 'package:pcnc_ecommerce/presentation/controller/logout_controller.dart';
import 'package:pcnc_ecommerce/presentation/controller/product_controller.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/category.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/products.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final AuthController authController = Get.put(
    AuthController(
      logoutUseCase: LogoutUseCase(
        repository: LogoutRepositoryImpl(
          storage: FlutterSecureStorage(),
          sharedPreferences: Get.find(),
        ),
      ),
    ),
  );
  final categoryController = Get.put(CategoryController());
   final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    categoryController.fetchCategories();
    productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title:  Row(
          children: [
        
            Padding(
              padding: EdgeInsets.only(left: 76),
              child : Container(
                height: 50,
                child: Image.asset("assets/images/name.png")),
            ),
          ],
        ),
        
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            iconSize: 35,
            onPressed: () {},
          ),
          
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
        
            ListTile(
              title:const  Padding(
                padding:  EdgeInsets.only(top: 400),
                child: Center(
                  
                  child: Text('Logout')),
              ),
              onTap: () {
                authController.logout();
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
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 3), // Shadow position
                ),
              ]),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search any Product...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  filled:
                      true, // Ensures the background is filled, showing the shadow
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          CategoryList(),
          SizedBox(height: 20),
          ProductList(), // Replace Expanded with ProductList widget
          // Other components can be added here
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Change background color here
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            label: 'Wishlist',
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
              Icons.settings,
              color: Colors.black,
            ),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
