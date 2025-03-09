import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/products/TBrandCard/t_brand_cart.dart';
import 'package:e_commerce/common/widgets/products/sortable/brand_sortabla_products.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, this.products});

  final List<ProductsModel>? products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(products![0].brand!.name!),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Brand Details
              TBrandCard(showBorder: true, brand: products![0].brand!),
              const SizedBox(height: TSizes.spaceBtwSections),

              TBrandSortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
