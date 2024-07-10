import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcnc_ecommerce/Data/repository/logoutRepository.dart';
import 'package:pcnc_ecommerce/Domain/usecases/logout_usecase.dart';
import 'package:pcnc_ecommerce/presentation/controller/category_controller.dart';
import 'package:pcnc_ecommerce/presentation/controller/logout_controller.dart';
import 'package:pcnc_ecommerce/presentation/controller/product_controller.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/Bottom_nav.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/Title.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/category.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/homeSearc_bar.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/products.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/tending_products.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/trending_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthController authController;
  late final CategoryController categoryController;
  late final ProductController productController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    authController = Get.put(
      AuthController(
        logoutUseCase: LogoutUseCase(
          repository: LogoutRepositoryImpl(
            storage: const FlutterSecureStorage(),
            sharedPreferences: Get.find(),
          ),
        ),
      ),
    );
    categoryController = Get.put(CategoryController());
    productController = Get.put(ProductController());

    categoryController.fetchCategories();
    productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 233, 229, 229),
                child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Image.asset('assets/images/menu.png')),
              ),
            );
          },
        ),
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40,
                width: 45,
                child: Image.asset('assets/images/name.png'),
              ),
              SizedBox(width: 8), // Space between image and text
              Container(
                height: 20,
                child: Text(
                  "PCNC",
                  style: GoogleFonts.libreCaslonText(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            iconSize: 45,
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(top: 400),
                child: Center(child: Text('Logout')),
              ),
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HomesearchBar(),
            const title(),
            const SizedBox(height: 20),
            CategoryList(),
            const SizedBox(height: 30),
            ProductList(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TrendingProductsWidget(),
            ),
            const SizedBox(height: 30),
            TendingProducts(),
            const SizedBox(height: 60),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin:
            EdgeInsets.only(top: 35, left: 15), // Adjust the margin as needed
        child: FloatingActionButton(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          onPressed: () {},
          backgroundColor: Colors.white,
          child: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                authController.logout(); // Call the logout method
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}