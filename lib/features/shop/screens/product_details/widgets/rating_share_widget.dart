import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key,
    this.product,
  });

  final ProductsModel? product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 1.5),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: product!.averageRating.toString() ?? "0.0",
                      style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(
                      text:
                          "(${product!.ratingCount!.toStringAsFixed(0).toString() ?? "0"})")
                ],
              ),
            )
          ],
        ),
        IconButton(
            onPressed: () {}, icon: Icon(Icons.share, size: TSizes.iconMd))
      ],
    );
  }
}
