import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_commerce/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:e_commerce/features/shop/controllers/banner_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      return controller.isLoading.value
          ? TShimmerEffect(width: double.infinity, height: 190)
          : Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlayInterval: Duration(seconds: 8),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    onPageChanged: (index, reason) =>
                        controller.updatePageIndicator(index),
                  ),
                  items: controller.banners
                      .map((banners) => TRoundedImage(
                            isShimmer: true,
                            imageUrl: banners.image,
                            isNetworkImage: true,
                            onPressed: () => Get.toNamed(banners.targetScreen),
                          ))
                      .toList(),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Center(
                  child: Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < controller.banners.length; i++)
                          TCircularContainer(
                            width: 20,
                            margin: EdgeInsets.only(right: 10),
                            height: 4,
                            backgroundColor:
                                controller.carouselCurrentIndex.value == i
                                    ? TColors.primary
                                    : TColors.grey,
                          ),
                      ],
                    ),
                  ),
                )
              ],
            );
    });
  }
}
