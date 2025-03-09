import 'package:e_commerce/common/widgets/layout/t_grid_layout.dart';
import 'package:e_commerce/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TVerticalProductShimmer extends StatelessWidget {
  const TVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: itemCount,
      itemBuilder: (context, index) => SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TShimmerEffect(width: 180, height: 200),
            const SizedBox(height: TSizes.spaceBtwItems),
            TShimmerEffect(width: 160, height: 15),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            TShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}
