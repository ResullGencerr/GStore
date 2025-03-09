import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:e_commerce/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:e_commerce/features/shop/controllers/product/product_image_slider_controller.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductImagesSlider extends StatelessWidget {
  const TProductImagesSlider({
    super.key,
    this.product,
  });

  final ProductsModel? product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final imageController = Get.put(ProductImageSliderController());
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.white,
        child: Stack(
          children: [
            Obx(
              () => SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => imageController.fullScreenImage(
                          product!.images![imageController.currentIndex.value]),
                      child: Hero(
                        tag: "fullScreenImage",
                        child: TRoundedImage(
                          isShimmer: true,
                          imageUrl: product!
                              .images![imageController.currentIndex.value],
                          backgroundColor: Colors.transparent,
                          isNetworkImage: true,
                          showProgressIndicator: false,
                          width: 300,
                          height: 400,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Image Slider

            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Obx(() {
                      bool isSelected =
                          imageController.currentIndex.value == index;
                      return GestureDetector(
                        onTap: () => imageController.updateSelectedImage(index),
                        child: TRoundedImage(
                          imageUrl: product!.images![index],
                          isNetworkImage: true,
                          isShimmer: true,
                          width: 80,
                          backgroundColor: dark ? TColors.dark : TColors.white,
                          border: Border.all(
                            color: isSelected
                                ? TColors.primary
                                : Colors.transparent,
                          ),
                          padding: EdgeInsets.all(TSizes.sm),
                        ),
                      );
                    });
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemCount: product!.images!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              ),
            ),
            // Appbar Icons

            TAppBar(
              showBackArrow: true,
              actions: [
                TFavoriteIcon(productId: product!.id!),
              ],
            )
          ],
        ),
      ),
    );
  }
}
