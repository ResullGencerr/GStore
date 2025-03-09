import 'package:e_commerce/common/widgets/paymet/paymet_tile.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/models/paymet_method_model.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController instance = Get.find();

 final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;


 @override
  void onInit(){
    selectedPaymentMethod.value = PaymentMethodModel(name: "MasterCard", image: TImages.masterCardIcon);
   super.onInit();
 }

  Future<dynamic> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(context: context, builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(TSizes.lg),
        child: Column(
          children: [
            TSectionHeading(title: "Ödeme Yöntemini Seçin", showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwSections),
            TPaymetTile(paymentMethod: PaymentMethodModel(name: "MasterCard", image: TImages.masterCardIcon)),
            const SizedBox(height: TSizes.spaceBtwItems/2),
            TPaymetTile(paymentMethod: PaymentMethodModel(name: "Visa", image: TImages.visaIcon)),
            const SizedBox(height: TSizes.spaceBtwItems/2),
            TPaymetTile(paymentMethod: PaymentMethodModel(name: "Paypal", image: TImages.paypalIcon)),
           const SizedBox(height: TSizes.spaceBtwItems/2),
            TPaymetTile(paymentMethod: PaymentMethodModel(name: "Apple Pay", image: TImages.applePayIcon)),
            const SizedBox(height: TSizes.spaceBtwItems/2),
            TPaymetTile(paymentMethod: PaymentMethodModel(name: "Google Pay", image: TImages.googlePayIcon)),
          ],
        )
      ),
    ));

  }

}