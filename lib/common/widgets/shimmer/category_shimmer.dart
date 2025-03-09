import 'package:e_commerce/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              //Image
              TShimmerEffect(width: 56, height: 56, radius: 55),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              // Text
              TShimmerEffect(width: 50, height: 8),
            ],
          );
        },
      ),
    );
  }
}
