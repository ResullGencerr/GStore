import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/icons/t_circular_icon.dart';
import 'package:e_commerce/common/widgets/layout/t_grid_layout.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/product/favorites_controller.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text("Favoriler",
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
              icon: Iconsax.add,
              onPressed: () =>
                  Get.find<NavigationController>().selectedIndex.value = 0),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              future: controller.favoriteProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return TVerticalProductShimmer(itemCount: 2);
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return TAnimationLoaderWidget(
                    text: "Henüz favorilere eklediğiniz bir ürün yok.",
                    animation: TImages.pencilAnimation,
                  );
                }

                return TGridLayout(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => TProductCardVertical(
                          product: snapshot.data![index],
                        ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
