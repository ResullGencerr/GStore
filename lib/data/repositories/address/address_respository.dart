import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:get/get.dart';

class AddressRespository extends GetxController {
  static AddressRespository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId = AuthenticationRespository.instance.authUser!.uid;
      if (userId.isEmpty) throw "User not logged in";

      final result = await _db
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .get();
      return result.docs
          .map((e) => AddressModel.fromDocumentSnapshot(e))
          .toList();
    } catch (e) {
      throw "Could not fetch user address";
    }
  }

  Future<void> updateAddress(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRespository.instance.authUser!.uid;
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .doc(addressId)
          .update({"SelectedAddres": selected});
    } catch (e) {
      throw "Could not update address";
    }
  }

  Future<String> createNewAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRespository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw "Could not create new address";
    }
  }
}
