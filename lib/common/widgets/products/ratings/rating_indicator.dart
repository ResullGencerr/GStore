import 'package:e_commerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key,
    required this.rating,
    this.onTap,
  });

  final double rating;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RatingBarIndicator(
        rating: rating,
        itemSize: 20,
        unratedColor: TColors.grey,
        itemBuilder: (context, _) => const Icon(
          Iconsax.star1,
          color: TColors.primary,
        ),
      ),
    );
  }
}
