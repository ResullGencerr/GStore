import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.isShimmer = false,
  });
  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final bool isShimmer;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.black
                : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: isNetworkImage
            ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  placeholder: (context, url) => isShimmer
                      ? TShimmerEffect(
                          width: double.infinity, height: double.infinity)
                      : SizedBox(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
            : Image(fit: fit, image: AssetImage(image), color: overlayColor),
      ),
    );
  }
}
