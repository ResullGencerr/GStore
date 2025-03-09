import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String? id;
  String? image;
  String? name;
  bool? isFeatured;
  double? productsCount;

  BrandModel({
    this.id,
    this.image,
    this.name,
    this.isFeatured,
    this.productsCount,
  });
  Map<String, dynamic> toJson() {
    return {
      "Image": image,
      "Name": name,
      "IsFeatured": isFeatured,
      "ProductsCount": productsCount,
    };
  }

  factory BrandModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BrandModel(
      id: document.id,
      image: data["Image"] ?? "",
      name: data["Name"] ?? "",
      isFeatured: data["IsFeatured"] ?? "",
      productsCount: (data["ProductsCount"] as num?)?.toDouble() ?? 0.0,
    );
  }
}
