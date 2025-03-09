import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:get/get.dart';

class BrandsRespository extends GetxController {
  static BrandsRespository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection("Brands").get();
      final response = snapshot.docs
          .map((document) => BrandModel.fromJson(document))
          .toList();
      return response;
    } catch (e) {
      throw "Something went wrong. Please try again later. Error: $e";
    }
  }

  Future<List<ProductsModel>> getBrandProducts(String brandId) async {
    try {
      final snapshot = await _db
          .collection("Products")
          .where("BrandId", isEqualTo: brandId)
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
}
