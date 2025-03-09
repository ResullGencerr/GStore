import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/features/personalization/models/order_model.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  Future<List<OrderModel>> fetchUserOders() async {
    try {
      final userId = AuthenticationRespository.instance.authUser!.uid;
      if(userId.isEmpty){
        throw "User is not logged in";
      }

      final result = await _db.collection("Users").doc(userId).collection("Orders").get();
      return result.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
      
    } catch (e) {
      throw "Error while fetching user orders $e";
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db.collection("Users").doc(userId).collection("Orders").doc(order.id).set(order.toJson());
    } catch (e) {
      throw "Error while saving order $e";
    }

  }
}