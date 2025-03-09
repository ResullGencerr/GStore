import 'package:e_commerce/common/widgets/layout/t_grid_layout.dart';
import 'package:e_commerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/category_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: FutureBuilder(
                future: controller.fetchStoreCategories(category.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return TVerticalProductShimmer();
                  }
                  return Column(
                    children: [
                      
                      TGridLayout(
                          itemCount: controller.allSubProducts.length,
                          itemBuilder: (context, index) => TProductCardVertical(
                              product: controller.allSubProducts[index])),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                    ],
                  );
                }),
          ),
        ]);
  }
}
