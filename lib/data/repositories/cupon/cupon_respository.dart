import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/personalization/models/cupons_model.dart';
import 'package:get/get.dart';


class CuponRespository  extends GetxController {
  static CuponRespository get instance => Get.find();

  
  final _db = FirebaseFirestore.instance;

Future<List<CuponModel>> getAllCupons() async {
  try {
    final result = await _db.collection("Cupons").get(); 
    return  result.docs.map((e)=>CuponModel.fromJson(e)).toList();
  } catch (e) {
    throw "Hata Oluştu $e";
  }
}

Future<CuponModel> getCupons (String cuponCode) async {
  try {  
    print("Sorgu Parametresi: $cuponCode");
    final result = await _db.collection("Cupons").where("CuponCode", isEqualTo: cuponCode).get();
     print("Sorgu Sonucu: ${result.docs.length}"); // kaç belge döndüğünü kontrol et
   if(result.docs.isNotEmpty){
          print("Kupon Kodu Bulundu: ${result.docs.first['CuponCode']}");
    return  CuponModel.fromJson(result.docs.first);
   }else{
    return CuponModel.empty();
   }
  } catch (e) {
    throw "Hata Oluştu $e";
  }
}


}

