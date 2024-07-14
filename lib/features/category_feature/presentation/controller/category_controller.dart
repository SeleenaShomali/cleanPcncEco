import 'package:get/get.dart';
import 'package:pcnc_ecommerce/features/category_feature/data/repo/category_repo.dart';
import 'package:pcnc_ecommerce/features/category_feature/domain/entities/categorymodel.dart';

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
      List<Category> fetchedCategories =
          categories.value = await _repository.fetchCategories();
      categories.value = fetchedCategories.take(10).toList();
      isError.value = false; // Use .value
    } catch (e) {
      isError.value = true; // Use .value
    } finally {
      isLoading.value = false; // Use .value
    }
  }
}
//  List<Product> fetchedProducts =
//           (await _repository.fetchProducts()).cast<Product>();
//       products.value = fetchedProducts.take(4).toList();