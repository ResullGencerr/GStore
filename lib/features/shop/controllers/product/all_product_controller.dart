import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/products/products_repository.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:get/get.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final isLoading = false.obs;
  final productsRepository = Get.put(ProductsRepository());
  RxList<ProductsModel> getAllProducts = <ProductsModel>[].obs;
  RxString selectedSortOption = "Ürün Adı".obs;
  @override
  void onInit() {
    fetchAllProduct();
    super.onInit();
  }

  fetchAllProduct() async {
    try {
      isLoading.value = true;
      update();
      final data = await productsRepository.getAllProducts();
      getAllProducts.assignAll(data);
    } catch (e) {
      TLoaders.errorSnackbar(title: "Verileri Getir", message: e.toString());
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

  void sortProducts() {
    switch (selectedSortOption.value) {
      case "Ürün Adı":
        getAllProducts.sort((a, b) => a.title!.compareTo(b.title!));
        break;
      case "Fiyat (En Yüksek)":
        getAllProducts.sort((a, b) => b.price!.compareTo(a.price!));
        break;
      case "Fiyat (En Düşük)":
        getAllProducts.sort((a, b) => a.price!.compareTo(b.price!));
        break;
      case "İndirimdekiler":
        getAllProducts.sort((a, b) =>
            (b.salePrice ?? b.price)!.compareTo((a.salePrice ?? a.price)!));
        break;
      case "En Popüler":
        getAllProducts
            .sort((a, b) => b.averageRating!.compareTo(a.averageRating!));
        break;
      default:
        break;
    }
    update();
  }

  void setSortOption(String option) {
    selectedSortOption.value = option;
    sortProducts();
  }
}
