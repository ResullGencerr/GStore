import 'package:cloud_firestore/cloud_firestore.dart';

class CuponModel{
 String? name;
 String? cuponCode;
 double? discount;

CuponModel({
   this.name,
   this.cuponCode,
   this.discount,
});

 static CuponModel empty()=> CuponModel(
  name: "",
  cuponCode:"",
  discount: 0.0,
 );
Map<String, dynamic> toJson() {
  return {
    "Name": name,
    "CuponCode": cuponCode,
    "Discount": discount,
  };
}



 factory CuponModel.fromJson(DocumentSnapshot document) {
  final data = document.data() as Map<String, dynamic>; 
  return CuponModel(
    name: data["Name"] ?? "",
    cuponCode: data["CuponCode"] ?? "",
    discount: (data["Discount"] as num?)?.toDouble() ?? 0.0,
  );
}
}