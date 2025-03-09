import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/enum.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.overflow,
    this.textColor,
    this.textSizes = TextSizes.small,
    this.textAlign = TextAlign.center,
    this.iconColor = TColors.primary,
  });

  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes textSizes;

  final TextOverflow? overflow;
  final Color? textColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            title,
            overflow: overflow,
            maxLines: maxLines,
            textAlign: textAlign,
            style: textSizes == TextSizes.small
                ? Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor)
                : textSizes == TextSizes.medium
                    ? Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: textColor)
                    : textSizes == TextSizes.large
                        ? Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: textColor)
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: textColor),
          ),
        ),
        const SizedBox(width: TSizes.xs),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: TSizes.iconXs,
        )
      ],
    );
  }
}
