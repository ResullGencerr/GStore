import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/brands/brands_respository.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/features/shop/screens/brand/brand_products.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final brandsRepository = Get.put(BrandsRespository());
  final isLoading = false.obs;
  RxList<BrandModel> getAllBrands = <BrandModel>[].obs;
  RxList<ProductsModel> getBrandProducts = <ProductsModel>[].obs;
  RxString selectedSortOption = "Ürün Adı".obs;

  @override
  void onInit() {
    fetchAllBrands();
    super.onInit();
  }

  void fetchAllBrands() async {
    try {
      isLoading.value = true;
      final data = await brandsRepository.getAllBrands();
      getAllBrands.assignAll(data);
      update();
    } catch (e) {
      TLoaders.errorSnackbar(title: "Markalarrrr!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goBrandProduct(
    String? brandId,
  ) async {
    try {
      final data = await brandsRepository.getBrandProducts(brandId!);
      getBrandProducts.assignAll(data);

      Get.to(() => BrandProductsScreen(products: getBrandProducts));
    } catch (e) {
      TLoaders.errorSnackbar(title: "Brandddd!", message: e.toString());
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
        getBrandProducts.sort((a, b) => a.title!.compareTo(b.title!));
        break;
      case "Fiyat (En Yüksek)":
        getBrandProducts.sort((a, b) => b.price!.compareTo(a.price!));
        break;
      case "Fiyat (En Düşük)":
        getBrandProducts.sort((a, b) => a.price!.compareTo(b.price!));
        break;
      case "İndirimdekiler":
        getBrandProducts.sort((a, b) =>
            (b.salePrice ?? b.price)!.compareTo((a.salePrice ?? a.price)!));
        break;
      case "En Popüler":
        getBrandProducts
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
