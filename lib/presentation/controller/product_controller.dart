import 'package:get/get.dart';
import 'package:pcnc_ecommerce/data/repository/product_repo.dart';
import 'package:pcnc_ecommerce/domain/entities/productmodel.dart';
import 'package:flutter/widgets.dart';

class ProductController extends GetxController {
  final ProductRepository _repository = ProductRepository();
  RxList<Product> products = RxList<Product>();
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProducts();
    });
    super.onInit();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      List<Product> fetchedProducts =
          (await _repository.fetchProducts()).cast<Product>();
      products.value = fetchedProducts.take(4).toList();
      isError.value = false;
    } catch (e) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
