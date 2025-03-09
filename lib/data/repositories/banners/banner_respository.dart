import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/models/banner_model.dart';

import 'package:get/get.dart';

class BannerRespository extends GetxService {
  static BannerRespository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection("Banners")
          .where("Active", isEqualTo: true)
          .get();
      return result.docs.map((e) => BannerModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw e;
    }
  }
}
