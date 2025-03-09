import 'package:e_commerce/common/widgets/icons/t_circular_icon.dart';
import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProductQuantitiyWithAddRemove extends StatelessWidget {
  const TProductQuantitiyWithAddRemove({
    super.key,
    this.cartItem,
  });

  final CartItemModel? cartItem;
  

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context);
   return Obx((){
       final productQuantityIncart = cartController.getProductQuntitiyInCart(cartItem!.productId);
      return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: dark ? TColors.white : TColors.black,
          backgroundColor: dark ? TColors.darkerGrey : TColors.light,
          onPressed: () => cartController.decreaseQuantity(cartItem!),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text(
          productQuantityIncart.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        TCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: TColors.white,
          backgroundColor: TColors.primary,
          onPressed: () => cartController.increaseQuantity(cartItem!),
        ),
      ],
    );
    });
  }
}
