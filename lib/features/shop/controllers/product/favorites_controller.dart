import 'dart:convert';

import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/products/products_repository.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  Future<void> initFavorites() async {
    final json = TLocalStorage.instance().readData("favorites");

    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStroga();
      TLoaders.customToast(message: "Ürün favori listenize eklendi.");
    } else {
      TLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStroga();
      favorites.refresh();
      TLoaders.customToast(message: "Ürün favori listenden çıkarıldı.");
    }
  }

  void saveFavoritesToStroga() async {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().saveData("favorites", encodedFavorites);
  }

  Future<List<ProductsModel>> favoriteProducts() async {
    return await ProductsRepository.instance
            .getFavoriteProducts(favorites.keys.toList()) ??
        [];
  }
}
