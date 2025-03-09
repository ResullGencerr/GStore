import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/categories/category_repository.dart';
import 'package:e_commerce/data/repositories/products/products_repository.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/features/shop/screens/sub_category/sub_categories.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  final _productRepository = ProductsRepository.instance;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> allSubCategories = <CategoryModel>[].obs;
  RxList<ProductsModel> allSubProducts = <ProductsModel>[].obs;

  @override
  void onInit() {
    fetchCategories();

    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);

      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
     throw e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStoreCategories(String parentCategoryId) async {
    try {
      isLoading.value = true;
      allSubCategories.clear();
      final categories =
          await _categoryRepository.getCategoriesByParentId(parentCategoryId);
      allSubCategories.assignAll(categories);

      if (allSubCategories.isEmpty) {
        return;
      }

      List<String> subCategoryIds = allSubCategories.map((e) => e.id).toList();

      final products =
          await _productRepository.getProductsByCategoryId(subCategoryIds);

      allSubProducts.clear();
      allSubProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackbar(title: "Mağzadakı Katehorılerrr", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSubCategories(
      String parentCategoryId, String parentCategoryName) async {
    try {
      allSubCategories.clear();
      final categories =
          await _categoryRepository.getCategoriesByParentId(parentCategoryId);
      allSubCategories.assignAll(categories);

      if (allSubCategories.isEmpty) {
        return;
      }
      allSubProducts.clear();
      List<String> subCategoryIds = allSubCategories.map((e) => e.id).toList();

      final products =
          await _productRepository.getProductsByCategoryId(subCategoryIds);
      allSubProducts.clear();
      allSubProducts.assignAll(products);

      Get.to(() => SubCategoriesScreen(
            parentCategoryName: parentCategoryName,
          ));
    } catch (e) {
      TLoaders.errorSnackbar(title: "AltKAtegorılerrr", message: e.toString());
    }
  }
}
