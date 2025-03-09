import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/products/ratings/rating_indicator.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:e_commerce/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key , this.product});
    final ProductsModel? product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Yorumlar"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Müşterilerimizin gerçek deneyimlerine dayanan puan ve yorumları görüntüleyin."),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Overall Product Rating

              TOverallPrdouctRating(rating:product!.averageRating!.toStringAsFixed(1),),
              TRatingBarIndicator(rating: product!.averageRating!),
              Text(product!.ratingCount!.toStringAsFixed(0), style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              UserReviewCard(),
              UserReviewCard(),
            
            ],
          ),
        ),
      ),
    );
  }
}
