import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/common/widgets/images/t_circular_image.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:e_commerce/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/enum.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, this.product});

  final ProductsModel? product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
        product!.price!, product!.salePrice!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price and Sale Price
        Column(
          children: [
            if (product!.salePrice != null && product!.salePrice! > 0)
              Row(
                children: [
                  TRoundedContainer(
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
                  const SizedBox(width: TSizes.spaceBtwItems),
                  //Price
                  ProductPriceText(
                    price: product?.price?.toString() ?? "",
                    lineThrough: true,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  ProductPriceText(
                      price: product?.salePrice?.toString() ?? "",
                      isLarge: true),
                ],
              )
            else
              ProductPriceText(
                  price: product?.price?.toString() ?? "", isLarge: true),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //Title
        TProductTitleText(title: product!.title!),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        // //Stock Status
        Row(
          children: [
            TProductTitleText(title: "Stok Durumu"),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product!.stock!.toInt()),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        //Brand
        Row(
          children: [
            TCircularImage(
              image: product!.brand!.image!,
              isNetworkImage: true,
              width: 50,
              height: 50,
              overlayColor: dark ? TColors.white : TColors.black,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: TBrandTitleWithVerifiedIcon(
                  title: product!.brand!.name!, textSizes: TextSizes.medium),
            ),
          ],
        )
      ],
    );
  }
}
