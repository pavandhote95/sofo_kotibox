import 'package:get/get.dart';

class VendorCategoriesController extends GetxController {
  final categories = <String>[
    'Electronics',
    'Groceries',
    'Clothing',
    'Home Decor',
    'Stationery',
    'Other'
  ].obs;

  final selectedCategories = <String>[].obs;
  final otherCategoryDetail = 'Handmade Crafts'.obs;

  @override
  void onInit() {
    super.onInit();
    // Set dummy selected categories
    selectedCategories.addAll(['Electronics', 'Clothing', 'Other']);
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void deleteCategory(String category) {
    selectedCategories.remove(category);
    if (category == 'Other') {
      otherCategoryDetail.value = '';
    }
  }
}
