import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoaders {
  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
          elevation: 0,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          content: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: THelperFunctions.isDarkMode(Get.context!)
                  ? TColors.darkerGrey.withOpacity(0.9)
                  : TColors.grey.withOpacity(0.9),
            ),
            child: Center(
                child: Text(message,
                    style: Theme.of(Get.context!).textTheme.labelLarge)),
          )),
    );
  }

  static successSnackbar({required title, message = ""}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: TColors.primary,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(20),
        icon: Icon(
          Iconsax.warning_2,
          color: TColors.white,
        ));
  }

  static warningSnacbar({required title, message = ""}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(20),
        icon: Icon(
          Iconsax.warning_2,
          color: TColors.white,
        ));
  }

  static errorSnackbar({required title, message = ""}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(20),
        icon: Icon(
          Iconsax.warning_2,
          color: TColors.white,
        ));
  }
}
