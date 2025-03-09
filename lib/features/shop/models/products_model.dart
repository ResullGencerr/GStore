import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';

class ProductsModel {
  String id;
  String? brandId;
  String? categoryId;
  String? description;
  List<String>? images;
  bool? isFeatured;
  double? price;
  String? productType;
  String? sku;
  double? salePrice;
  double? stock;
  String? thumbnail;
  String? title;
  BrandModel? brand;
  double? totalRating;
  double? ratingCount;
  double? averageRating;
  List<ProductAttributeModel>? productAttributes;

  ProductsModel({
    required this.id,
    this.brandId,
    this.categoryId,
    this.description,
    this.images,
    this.isFeatured,
    this.price,
    this.productType,
    this.sku,
    this.salePrice,
    this.stock,
    this.thumbnail,
    this.title,
    this.productAttributes,
    this.brand,
    this.totalRating,
    this.ratingCount,
    this.averageRating,
  });

  Map<String, dynamic> toJson() {
    return {
      "BrandId": brandId,
      "CategoryId": categoryId,
      "Description": description,
      "Images": images ?? [],
      "IsFeatured": isFeatured,
      "Price": price,
      "ProductType": productType,
      "SKU": sku,
      "SalePrice": salePrice,
      "Stock": stock,
      "TotalRating": totalRating,
      "RatingCount": ratingCount,
      "AverageRating": averageRating,
      "Thumbnail": thumbnail,
      "Title": title,
      "ProductAttributes": productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  factory ProductsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductsModel(
      id: document.id,
      brandId: data["BrandId"] ?? "",
      categoryId: data["CategoryId"] ?? "",
      description: data["Description"] ?? "",
      images: data["Images"] != null ? List<String>.from(data["Images"]) : [],
      isFeatured: data["IsFeatured"] ?? false,
      price: (data["Price"] as num?)?.toDouble() ?? 0.0,
      productType: data["ProductType"] ?? "",
      sku: data["SKU"] ?? "",
      totalRating: (data["TotalRating"] as num?)?.toDouble() ?? 0.0,
      ratingCount: (data["RatingCount"] as num?)?.toDouble() ?? 0.0,
      averageRating: (data["AverageRating"] as num?)?.toDouble() ?? 0.0,
      salePrice: (data["SalePrice"] as num?)?.toDouble() ?? 0.0,
      stock: (data["Stock"] as num?)?.toDouble() ?? 0.0,
      thumbnail: data["Thumbnail"] ?? "",
      title: data["Title"] ?? "",
      productAttributes: (data["ProductAttributes"] as List<dynamic>?)
              ?.map((e) => ProductAttributeModel.fromJson(e))
              .toList() ??
          [],
      brand: data["Brand"],
    );
  }
}

class ProductAttributeModel {
  String? name;
  List<String>? values;

  ProductAttributeModel({
    this.name,
    this.values,
  });

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Values": values,
    };
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    return ProductAttributeModel(
      name: data.containsKey("Name") ? data["Name"] : "",
      values: document.containsKey("Values")
          ? List<String>.from(document["Values"])
          : [],
    );
  }
}
