import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcnc_ecommerce/features/category_feature/presentation/controller/category_controller.dart';
import 'package:pcnc_ecommerce/features/logout_feature/data/repo/logoutRepository.dart';
import 'package:pcnc_ecommerce/features/logout_feature/domain/usecase/logout_usecase.dart';

import 'package:pcnc_ecommerce/features/logout_feature/presentation/controller/logout_controller.dart';
import 'package:pcnc_ecommerce/features/products_feature/presentation/controller/product_controller.dart';
import 'package:pcnc_ecommerce/features/dashboard/presentation/components/Bottom_nav.dart';
import 'package:pcnc_ecommerce/features/dashboard/presentation/components/Title.dart';
import 'package:pcnc_ecommerce/features/category_feature/presentation/view/category.dart';
import 'package:pcnc_ecommerce/features/dashboard/presentation/components/homeSearc_bar.dart';
import 'package:pcnc_ecommerce/features/products_feature/presentation/view/products.dart';
import 'package:pcnc_ecommerce/features/products_feature/presentation/components/tending_products.dart';
import 'package:pcnc_ecommerce/features/dashboard/presentation/components/trending_bar.dart';

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
                backgroundColor: Color.fromARGB(255, 246, 242, 242),
                child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: SvgPicture.asset('assets/images/Component1.svg')),
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
                width: 40,
                child: Image.asset('assets/images/name.png'),
              ),
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
        return Obx(() {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text('Logout'),
            content: authController.isLoading.value
                ? Container(
                    height: 100, // Adjust height as needed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Logging out...'),
                      ],
                    ),
                  )
                : const Text('Are you sure you want to logout?'),
            actions: <Widget>[
              if (!authController.isLoading.value)
                TextButton(
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  },
                  child: const Text('Cancel'),
                ),
              if (!authController.isLoading.value)
                TextButton(
                  onPressed: () async {
                    authController.isLoading.value = true;
                    await authController.logout(); // Call the logout method
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context)
                          .pop(); // Close the dialog after logout
                    }
                  },
                  child: const Text('Logout'),
                ),
            ],
          );
        });
      },
    );
  }
}