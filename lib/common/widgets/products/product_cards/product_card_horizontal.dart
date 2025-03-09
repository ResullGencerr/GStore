import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:e_commerce/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/features/shop/screens/product_details/product_detail.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key, this.product});
  final ProductsModel? product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
        product!.price!, product!.salePrice!);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.softGrey,
        ),
        child: Row(
          children: [
            // Thumbnail
            TRoundedContainer(
              height: 120,
              padding: EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.white,
              child: Stack(
                children: [
                  // Thumbnail Image
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: TRoundedImage(
                      imageUrl: product?.thumbnail ?? "",
                      backgroundColor: Colors.transparent,
                      isShimmer: true,
                      isNetworkImage: true,
                    ),
                  ),

                  // Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text("$salePercentage%",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: TColors.black)),
                      ),
                    ),

                  // Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TFavoriteIcon(productId: product!.id),
                  ),
                ],
              ),
            ),

            // Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTitleText(
                            title: product?.title ?? "", smallSize: true),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                        TBrandTitleWithVerifiedIcon(
                          title: product?.brand?.name ?? "",
                        )
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product?.salePrice != null &&
                                product!.salePrice! > 0) ...[
                              ProductPriceText(
                                price: product?.price?.toString() ?? "0",
                                lineThrough: true,
                                salePrice: true,
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems / 4),
                              ProductPriceText(
                                price: product?.salePrice?.toString() ?? "0",
                              ),
                            ] else
                              ProductPriceText(
                                price: product?.price?.toString() ?? "0",
                              ),
                          ],
                        ),

                        // Add to Cart Button
                        Container(
                          decoration: BoxDecoration(
                            color: TColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(TSizes.cardRadiusMd),
                              bottomRight:
                                  Radius.circular(TSizes.productImageRadius),
                            ),
                          ),
                          child: SizedBox(
                            height: TSizes.iconLg * 1.2,
                            width: TSizes.iconLg * 1.2,
                            child: Center(
                              child: Icon(
                                Iconsax.add,
                                color: TColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
