import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pcnc_ecommerce/presentation/controller/product_controller.dart';

import 'package:pcnc_ecommerce/domain/entities/productmodel.dart';

class TendingProducts extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  TendingProducts({super.key});

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
        return Expanded(
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              
              crossAxisCount: 1,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio:
                  0.71, // Adjusted child aspect ratio to match 241/170
            ),
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: productController.products[index]);
            },
          ),
        );
      }
    });
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 11),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: SizedBox(
          width: 241, // Width as per Figma design
          height: 170, // Height as per Figma design
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                child: AspectRatio(
                  aspectRatio: 1.55,
                  child: product.images.isNotEmpty
                      ? Image.network(
                          product.images[0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error_outline),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.image_not_supported),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12, // Adjusted font size
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10, // Adjusted font size
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Adjusted font size
                        color: Colors.black,
                      ),
                    ),
                  
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
