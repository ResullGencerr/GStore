import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/layout/t_grid_layout.dart';
import 'package:e_commerce/common/widgets/products/TBrandCard/t_brand_cart.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key, this.brand});

  final List<BrandModel>? brand;

  @override
  Widget build(BuildContext context) {
    final brandsController = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text("Öne Çıkan Markalar"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Heading
              TSectionHeading(title: "Markalar", showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Brands

              TGridLayout(
                itemCount: brand?.length ?? 0,
                mainAxisExtent: 80,
                itemBuilder: (p0, p1) => TBrandCard(
                  brand: brand![p1],
                  showBorder: true,
                  onPressed: () =>
                      brandsController.goBrandProduct(brand![p1].id),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
