import 'package:e_commerce/features/shop/screens/product_reviews/widgets/t_progress_indicator.dart';
import 'package:flutter/material.dart';

class TOverallPrdouctRating extends StatelessWidget {
  const TOverallPrdouctRating({
    super.key,
   this.rating,
  });
  final String? rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            rating ?? "4.0",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
            flex: 7,
            child: Column(
              children: [
                TRatingProgressIndicator(text: "5", value: 0.9),
                TRatingProgressIndicator(text: "4", value: 0.8),
                TRatingProgressIndicator(text: "3", value: 0.6),
                TRatingProgressIndicator(text: "2", value: 0.4),
                TRatingProgressIndicator(text: "1", value: 0.2),
              ],
            ))
      ],
    );
  }
}
