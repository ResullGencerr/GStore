
import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/products/products_repository.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productsRepository = Get.put(ProductsRepository());
  RxList<ProductsModel> getFeaturedProducts = <ProductsModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      update();
      final data = await productsRepository.getFeaturedProducts();
      getFeaturedProducts.assignAll(data);
    } catch (e) {
      throw e;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  String? calculateSalePercentage(double price, double salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (price == null || price <= 0.0) return null;

    double percentage = ((price - salePrice) / price) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? "Stokta" : "Stok Yok";
  }
}
