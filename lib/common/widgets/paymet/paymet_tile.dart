import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/features/shop/controllers/product/checkout_controller.dart';
import 'package:e_commerce/features/shop/models/paymet_method_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TPaymetTile extends StatelessWidget {
  const TPaymetTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      onTap: (){
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      contentPadding: EdgeInsets.zero,
      leading: TRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.light : TColors.white,
        padding: EdgeInsets.all(TSizes.sm),
        child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain)   
      ),
      title: Text(paymentMethod.name),
      trailing: Icon(Iconsax.arrow_right_34),
    );
  }
}