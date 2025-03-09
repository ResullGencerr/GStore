import 'package:e_commerce/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/product/checkout_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingPaymetSection extends StatelessWidget {
  const TBillingPaymetSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(
            title: "Ödeme Yöntemi", buttonTitle: "Değiştir", onPressed: ()=> controller.selectPaymentMethod(context)),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Obx(() => Row(
          children: [
            TRoundedImage(
              imageUrl: controller.selectedPaymentMethod.value.image,
              width: 60,
              height: 35,
              fit: BoxFit.contain,
              backgroundColor: dark ? TColors.light : TColors.white,
              padding: EdgeInsets.all(TSizes.sm),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text(
              controller.selectedPaymentMethod.value.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        ),
      ],
    );
  }
}
