import 'package:e_commerce/common/widgets/custom_shapes/containers/primay_header_container.dart';
import 'package:e_commerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_commerce/common/widgets/layout/t_grid_layout.dart';
import 'package:e_commerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text_strings.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Container Design
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // Appbar
                  THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  // Searchbar
                  TSearchContainer(text: TTexts.searchBarInStore),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  //Categories
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // Section Heading
                        TSectionHeading(
                          title: TTexts.popularCategories,
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        // Categories
                        THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // Body Container Design

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Promo Slider
                  TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // --Popular Products

                  TSectionHeading(
                    title: TTexts.popularProducts,
                    onPressed: () => Get.to(() => AllProductsScreen()),
                    textColor: THelperFunctions.isDarkMode(context)
                        ? TColors.white
                        : TColors.dark,
                  ),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return TVerticalProductShimmer();
                    }
                    return TGridLayout(
                      itemCount: controller.getFeaturedProducts.length,
                      itemBuilder: (context, index) => TProductCardVertical(
                        product: controller.getFeaturedProducts[index],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
