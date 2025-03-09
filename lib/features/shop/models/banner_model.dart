import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String image;
  final bool isActive;
  final String targetScreen;

  BannerModel({
    required this.image,
    required this.isActive,
    required this.targetScreen,
  });

  Map<String, dynamic> toJson() {
    return {
      "ImageUrl": image,
      "Active": isActive,
      "TargetScreen": targetScreen,
    };
  }

  factory BannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BannerModel(
      image: data["ImageUrl"] ?? "",
      isActive: data["Active"] ?? false,
      targetScreen: data["TargetScreen"] ?? "",
    );
  }
}
