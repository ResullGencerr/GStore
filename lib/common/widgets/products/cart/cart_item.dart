import 'package:e_commerce/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        // Image
        TRoundedImage(
          imageUrl: cartItem.image??"",      
          isNetworkImage: true,
          width: 60,
          height: 60,
          padding: EdgeInsets.all(TSizes.sm),
          backgroundColor: dark ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleWithVerifiedIcon(title: cartItem.brandName??""),
              TProductTitleText(
                title: cartItem.title,
                maxLines: 1,
              ),          
            ],
          ),
        )
      ],
    );
  }
}
