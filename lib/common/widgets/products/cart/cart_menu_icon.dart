import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce/features/shop/screens/cart/cart.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({super.key, this.iconColor, required this.onPressed});
  final Color? iconColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller= Get.put(CartController());
    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => CartScreen()),
          icon: Icon(Iconsax.shopping_bag,
              color: iconColor != null
                  ? iconColor!
                  : dark
                      ? TColors.white
                      : TColors.black),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: TColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(()=>Text(controller.totalCartItems.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .apply(color: TColors.white, fontSizeFactor: 0.8)
                      ),
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
