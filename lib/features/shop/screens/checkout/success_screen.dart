import 'package:e_commerce/common/styles/spacing_style.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithappBarHeight * 2,
          child: Column(
            children: [
              // Image
              Image(
                  image: AssetImage(TImages.successfulPaymetIcon),
                  width: THelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Title and Subtitle
              Text("Ödeme Başarılı!",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text("Siparişiniz yakında kargoya verilecektir.",
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.offAll(() => NavigationMenu()),
                    child: Text("Alışverişe Devam Et")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
