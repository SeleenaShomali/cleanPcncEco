// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcnc_ecommerce/presentation/controller/product_controller.dart';
import 'package:pcnc_ecommerce/domain/entities/productmodel.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/FullImage.dart';

class ProductList extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (productController.isError.value) {
        return const Center(child: Text('Failed to load products'));
      } else if (productController.products.isEmpty) {
        return const Center(child: Text('No products available'));
      } else {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72, // Adjust the aspect ratio as needed
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 20, // Spacing between rows
          ),
          itemCount: productController.products.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(
                product: productController.products[index], tagIndex: index);
          },
        );
      }
    });
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int tagIndex;

  const ProductCard({Key? key, required this.product, required this.tagIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(
                        imageUrl:
                            product.images.isNotEmpty ? product.images[0] : ''),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: AspectRatio(
                  aspectRatio: 1.31, // Adjust aspect ratio as needed
                  child: product.images.isNotEmpty
                      ? Hero(
                          tag: 'hero-tag-$tagIndex',
                          child: Image.network(
                            product.images[0],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.error_outline),
                              );
                            },
                          ),
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10, // Adjusted font size
                      color: Colors.black,
                      letterSpacing: 0.4,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // Adjusted font size
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector.svg',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 10,),
                      // SvgPicture.asset(
                      //   'assets/images/Vector1.svg',
                      //   height: 20,
                      //   width: 20,
                      // ),
                      Image.asset('assets/images/Bookmark.png'),

                      const SizedBox(width: 100),
                        SvgPicture.asset(
                        'assets/images/Vector1.svg',
                        height: 20,
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
