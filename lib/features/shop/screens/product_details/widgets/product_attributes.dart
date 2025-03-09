import 'package:e_commerce/common/widgets/chips/choice_chip.dart';
import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // Selected Attribute Pricing and Description
        TRoundedContainer(
          padding: EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              // Title Price and Stock Status
              Row(
                children: [
                  TSectionHeading(title: "Variation", showActionButton: false),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TProductTitleText(title: "Price : ", smallSize: true),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          ProductPriceText(price: "25", lineThrough: true),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          ProductPriceText(price: "20", isLarge: true),
                        ],
                      ),
                      // Stock Status

                      Row(
                        children: [
                          TProductTitleText(title: "Stock : ", smallSize: true),
                          Text("In Stock",
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              TProductTitleText(
                title:
                    "This is the Description of the Product and it can go up to max 4 lines",
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        // Attributes

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(
              title: "Colors",
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                    text: "Green", selected: false, onSelected: (value) {}),
                TChoiceChip(
                    text: "Blue", selected: true, onSelected: (value) {}),
                TChoiceChip(
                    text: "Yellow", selected: false, onSelected: (value) {}),
              ],
            )
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(
              title: "Size",
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 10,
              children: [
                TChoiceChip(
                    text: "EU 34", selected: false, onSelected: (value) {}),
                TChoiceChip(
                    text: "EU 36", selected: true, onSelected: (value) {}),
                TChoiceChip(
                    text: "EU 38", selected: false, onSelected: (value) {})
              ],
            ),
          ],
        ),
      ],
    );
  }
}
