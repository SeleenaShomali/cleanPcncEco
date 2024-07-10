import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pcnc_ecommerce/presentation/controller/product_controller.dart';
import 'package:pcnc_ecommerce/domain/entities/productmodel.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/FullImage.dart';

class TendingProducts extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  TendingProducts({Key? key}) : super(key: key);

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
        return SizedBox(
          height: 250,
          width: 100, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TendingProductCard(
                    product: productController.products[index]),
              );
            },
          ),
        );
      }
    });
  }
}

class TendingProductCard extends StatelessWidget {
  final Product product;

  const TendingProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: SizedBox(
        width: 180, // Width as per Figma design
        height: 170, // Height as per Figma design
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FullScreenImage(imageUrl: product.images[0])));
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: AspectRatio(
                  aspectRatio: 1.4, // Adjusted aspect ratio
                  child: product.images.isNotEmpty
                      ? Hero(
                        tag: product.images[0],
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
                  // Text(
                  //   product.title,
                  //   maxLines: 5,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: GoogleFonts.montserrat(
                  //     textStyle: const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 12, // Adjusted font size
                  //   ),
                  //   ),

                  // ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 12, // Adjusted font size
                          color: Colors.black,
                          height: 1.4,
                          fontWeight: FontWeight.w400),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
