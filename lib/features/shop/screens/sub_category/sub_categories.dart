import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/banner_controller.dart';
import 'package:e_commerce/features/shop/controllers/category_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, this.parentCategoryName});

  final String? parentCategoryName;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final bannerControl = BannerController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(parentCategoryName!),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              TRoundedImage(
                  imageUrl: bannerControl.banners.first.image,isNetworkImage: true, isShimmer: true ,width: double.infinity),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Sub Categories
              Obx(
                () {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: TSizes.spaceBtwItems),
                      itemCount: controller.allSubCategories.length,
                      itemBuilder: (context, index) {
                        var category = controller.allSubCategories[index];

                        var products = controller.allSubProducts
                            .where((products) =>
                                products.categoryId == category.id)
                            .toList();

                        return Column(
                          children: [
                            // Heading
                            TSectionHeading(title: category.name),
                            const SizedBox(height: TSizes.spaceBtwItems / 2),

                            SizedBox(
                              height: 120,
                              child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          width: TSizes.spaceBtwItems),
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    print(
                                        "Ana verilerimmmmmm product ${products.length}");
                                    print(
                                        "Ana verilerimmmmmm product ${products[index].title}");
                                    return TProductCardHorizontal(
                                        product: products[index]);
                                  }),
                            ),
                          ],
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
