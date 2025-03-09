import 'package:e_commerce/common/widgets/layout/t_grid_layout.dart';
import 'package:e_commerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TBrandSortableProducts extends StatelessWidget {
  const TBrandSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Column(
      children: [
        // Dropdown Menu
        Obx(
          () => DropdownButtonFormField(
            decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            value: controller.selectedSortOption.value,
            onChanged: (value) {
              if (value != null) controller.setSortOption(value);
            },
            items: [
              "Ürün Adı",
              "Fiyat (En Yüksek)",
              "Fiyat (En Düşük)",
              "İndirimdekiler",
              "En Popüler"
            ]
                .map((item) => DropdownMenuItem(child: Text(item), value: item))
                .toList(),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Products
        Obx(() {
          return controller.isLoading.value
              ? TVerticalProductShimmer(
                  itemCount: controller.getBrandProducts.length)
              : TGridLayout(
                  itemCount: controller.getBrandProducts.length,
                  itemBuilder: (context, index) => TProductCardVertical(
                    product: controller.getBrandProducts[index],
                  ),
                );
        }),
      ],
    );
  }
}
