import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:e_commerce/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, this.product});

  final ProductsModel? product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1- Product Image Slider
            TProductImagesSlider(
              product: product,
            ),

            // 2- Product Details
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  TRatingAndShare(product: product),
                  ProductMetaData(product: product),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                           final cart = controller.convertToCartItem(product!, 1);
                           controller.addToCartAndCheackOut(cart);


                          }, child: Text("Satın Al"))),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                      title: "Açıklama", showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    product?.description ?? "Açıklama mevcut değil",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Daha Fazla",
                    trimExpandedText: "Daha Az",
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(
                          title: "Yorumlar (10)", showActionButton: false),
                      IconButton(
                          icon: Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                          ),
                          onPressed: () =>
                              Get.to(() => ProductReviewsScreen(product: product,))),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            ),

            /* Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  // Rating and Share Buttons
                  TRatingAndShare(product: product),
                  // Price Title Stock Brand
                  ProductMetaData(product: product),
                  // Attributes
                  // TProductAttributes(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  // Checkout Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Checkout"))),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  // Description
                  const TSectionHeading(
                      title: "Açıklama", showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    product?.description ?? "Açıklama mevcut değil",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Daha Fazla",
                    trimExpandedText: "Daha Az",
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
        
                  // Reviews
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(
                          title: "Reviews (199)", showActionButton: false),
                      IconButton(
                          icon: Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                          ),
                          onPressed: () =>
                              Get.to(() => ProductReviewsScreen())),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
