import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/cupon/cupon_respository.dart';
import 'package:e_commerce/features/personalization/models/cupons_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CuponController extends GetxController{
  static CuponController get instance => Get.find();



  final cuponRepository = Get.put(CuponRespository());
  RxString cuponCodes = "".obs;
  RxDouble discount = 0.0.obs;

 final cupon = TextEditingController();
 GlobalKey<FormState> cuponFormKey = GlobalKey<FormState>();
  



  Future<List<CuponModel>> fetchCupons() async{
    try {
      final fetchCupons = await cuponRepository.getAllCupons();
     return fetchCupons;
    } catch (e) {
      throw "Hata Oluştu $e";
    }
  }

  void copyCuponCode(String cuponCode){
    cuponCodes.value = cuponCode;
    Clipboard.setData(ClipboardData(text: cuponCode)); // Kuponu kopyala
     TLoaders.customToast(message:  "Kupon kodu panoya kopyalandı!");       
  }

void applyCuponCode(String cuponCode) async {
  try {
    if (!cuponFormKey.currentState!.validate()) {
      return;
    }

    final result = await cuponRepository.getCupons(cuponCode);

    if (result.discount == 0.0) {  // Geçersiz kupon
      TLoaders.customToast(message: "Kupon Kodu Geçersiz");
    } else {  // Geçerli kupon
      discount.value = result.discount!;
      TLoaders.customToast(message: "Kuponunuz Başarıyla Uygulandı");
      update();
      print("Kupon İndirim: ${discount.value}");
    }
  } catch (e) {
    throw "Hata $e";
  }
}

void clearCupon(){
  cupon.text = "";
  discount.value = 0;
  update(); 
}

}