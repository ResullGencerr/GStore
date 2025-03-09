import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImageSliderController extends GetxController {
  static ProductImageSliderController get instance => Get.find();

  RxInt currentIndex = 0.obs;

  void onInit() {
    super.onInit();
    currentIndex.value = 0;
  }

  void updateSelectedImage(int index) {
    currentIndex.value = index;
  }

  void fullScreenImage(String imageUrl) {
    showDialog(
        context: Get.overlayContext!,
        builder: (context) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Dialog(
              insetPadding: EdgeInsets.all(0),
              child: TRoundedContainer(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(TSizes.sm),
                backgroundColor: TColors.white,
                radius: 0,
                child: Center(
                    child: Hero(
                  tag: "fullScreenImage",
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: TRoundedImage(
                      backgroundColor: Colors.transparent,
                      width: TDeviceUtility.getScreenWidth(context) * 0.8,
                      height: TDeviceUtility.getScreenHeight(context) * 0.8,
                      fit: BoxFit.contain,
                      imageUrl: imageUrl,
                      isNetworkImage: true,
                    ),
                  ),
                )),
              ),
            ),
          );
        });
  }
}
