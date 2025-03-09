import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Gel All Categories

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      throw e;
    }
  }

  Future<List<CategoryModel>> getCategoriesByParentId(String parentId) async {
    try {
      final snapshot = await _db
          .collection("Categories")
          .where("ParentId", isEqualTo: parentId)
          .get();
      final result = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return result;
    } catch (e) {
      throw e;
    }
  }
}
