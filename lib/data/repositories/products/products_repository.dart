import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:get/get.dart';

class ProductsRepository extends GetxController {
  static ProductsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ProductsModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection("Products")
          .where("IsFeatured", isEqualTo: true)
          .get();
      List<ProductsModel> products =
          snapshot.docs.map((e) => ProductsModel.fromSnapshot(e)).toList();

      for (var product in products) {
        if (product.brandId != null) {
          final brand =
              await _db.collection("Brands").doc(product.brandId!).get();
          if (brand.exists) {
            product.brand = BrandModel.fromJson(brand);
          }
        }
      }
      return products;
    } catch (e) {
      throw "Something went wrong. Please try again later. Error: $e";
    }
  }

  Future<List<ProductsModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection("Products").get();
      List<ProductsModel> products =
          snapshot.docs.map((e) => ProductsModel.fromSnapshot(e)).toList();
      for (var product in products) {
        if (product.brandId != null) {
          final brand =
              await _db.collection("Brands").doc(product.brandId!).get();
          if (brand.exists) {
            product.brand = BrandModel.fromJson(brand);
          }
        }
      }
      return products;
    } catch (e) {
      throw "Something went wrong. Please try again later. Error: $e";
    }
  }

  Future<List<ProductsModel>> getProductsByCategoryId(
      List<String> categoryId) async {
    try {
      final snapshot = await _db
          .collection("Products")
          .where("CategoryId", whereIn: categoryId)
          .get();

      List<ProductsModel> result = snapshot.docs
          .map((document) => ProductsModel.fromSnapshot(document))
          .toList();
      for (var product in result) {
        if (product.brandId != null) {
          final brand =
              await _db.collection("Brands").doc(product.brandId!).get();
          if (brand.exists) {
            product.brand = BrandModel.fromJson(brand);
          }
        }
      }
      return result;
    } catch (e) {
      throw "Something went wrong. Please try again later. Error: $e";
    }
  }

  Future<List<ProductsModel>> getFavoriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection("Products")
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductsModel> result = snapshot.docs
          .map((document) => ProductsModel.fromSnapshot(document))
          .toList();
      for (var product in result) {
        if (product.brandId != null) {
          final brand =
              await _db.collection("Brands").doc(product.brandId!).get();
          if (brand.exists) {
            product.brand = BrandModel.fromJson(brand);
          }
        }
      }
      return result;
    } catch (e) {
      throw "Something went wrong. Please try again later. Error: $e";
    }
  }
}
