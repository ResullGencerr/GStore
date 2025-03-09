import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/common/widgets/products/TBrandCard/t_brand_cart.dart';
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.images,
  });
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.all(TSizes.md),
      margin: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          TBrandCard(showBorder: false),
          Row(
            children: images
                .map((image) => brandTopProductImageWidgets(context, image))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget brandTopProductImageWidgets(BuildContext context, String image) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.light,
        margin: EdgeInsets.only(right: TSizes.sm),
        padding: EdgeInsets.all(TSizes.md),
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
