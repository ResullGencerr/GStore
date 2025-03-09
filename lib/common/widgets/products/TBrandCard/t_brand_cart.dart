import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/common/widgets/images/t_circular_image.dart';
import 'package:e_commerce/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:e_commerce/utils/constants/enum.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onPressed,
    this.brand,
  });

  final bool showBorder;
  final void Function()? onPressed;
  final BrandModel? brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: TRoundedContainer(
        padding: EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // Icon
            Flexible(
              child: TCircularImage(
                isNetworkImage: true,
                fit: BoxFit.contain,
                isShimmer: true,
                image: brand!.image!,
                backgroundColor: Colors.transparent,
                overlayColor: THelperFunctions.isDarkMode(context)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            // Text
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifiedIcon(
                    title: brand!.name!,
                    textSizes: TextSizes.large,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${brand!.productsCount!.toStringAsFixed(0).toString()} ürün",
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
