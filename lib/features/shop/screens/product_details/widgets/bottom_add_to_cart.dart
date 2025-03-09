import 'package:e_commerce/common/widgets/icons/t_circular_icon.dart';
import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, this.product});

  final ProductsModel? product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    return Obx((){
     return Container(
      padding: EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.darkGrey,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  if(cartController.addToCartCount.value>0){
                    cartController.addToCartCount.value--;
                  }
                },
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(
                cartController.addToCartCount.value.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  cartController.addToCartCount.value++;
                },
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              final newItem = cartController.convertToCartItem(product!, cartController.addToCartCount.value);
              cartController.productDetailAddToCart(newItem, cartController.addToCartCount.value);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.black,
              side: BorderSide(color: TColors.black),
            ),
            child: Text("Sepete Ekle"),
          ),
        ],
      ),
    );
    });
  }
}
