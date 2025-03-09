import 'package:e_commerce/common/styles/shadows.dart';
import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce/common/widgets/products/cart/product_card_add_to_cart_button.dart';
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

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key,  required this.product});

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
        product.price!, product.salePrice!);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkerGrey : TColors.white),
        child: Column(
          children: [
            // Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 180,
              width: 180,
              padding: EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.white,
              child: Stack(
                // Thumbnail Image
                children: [
                  Center(
                    child: TRoundedImage(
                      imageUrl: product.thumbnail ?? "",
                      isShimmer: true,
                      backgroundColor: Colors.transparent,
                      isNetworkImage: true,
                      fit: BoxFit.contain,
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
                    child: TFavoriteIcon(productId: product.id),
                  )
                ],
              ),
            ),

            // Details
            Padding(
              padding: EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(
                    title: product.title ?? "",
                    smallSize: true,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TBrandTitleWithVerifiedIcon(
                    title: product.brand!.name!,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (product.salePrice != null && product.salePrice! > 0)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: TSizes.sm, bottom: TSizes.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductPriceText(
                              price: product.price?.toString() ?? "",
                              lineThrough: true,
                              salePrice: true,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems / 4),
                            ProductPriceText(
                              price: product.salePrice?.toString() ?? "",
                            ),
                          ],
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(
                            left: TSizes.sm, bottom: TSizes.sm),
                        child: ProductPriceText(
                          price: product.price?.toString() ?? "",
                        ),
                      ),
                  ],
                ),
                ProductCardAddToCartButton(product:product)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

