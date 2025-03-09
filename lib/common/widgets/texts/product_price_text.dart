import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    this.currenctSign = "₺",
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
    this.salePrice = false,
  });

  final String currenctSign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;
  final bool salePrice;

  @override
  Widget build(BuildContext context) {
    return Text(
      currenctSign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: salePrice
          ? Theme.of(context).textTheme.bodySmall!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : isLarge
              ? Theme.of(context).textTheme.headlineMedium!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null)
              : Theme.of(context).textTheme.titleLarge!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
