import 'package:get/get.dart';
import 'package:pcnc_ecommerce/Data/repository/category_repo.dart';

import 'package:pcnc_ecommerce/domain/entities/categorymodel.dart';

class CategoryController extends GetxController {
  final CategoryRepository _repository = CategoryRepository();
  RxList<Category> categories = <Category>[].obs;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs; // Use .obs() instead of .obs

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true; // Use .value
    try {
      categories.value = await _repository.fetchCategories();
      isError.value = false; // Use .value
    } catch (e) {
      isError.value = true; // Use .value
    } finally {
      isLoading.value = false; // Use .value
    }
  }
}
