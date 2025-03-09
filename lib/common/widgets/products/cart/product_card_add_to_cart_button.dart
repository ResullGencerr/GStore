import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        final cartItem = cartController.convertToCartItem(product,1);
        cartController.addToCart(cartItem);
      },
      child:Obx((){
        final productQuantityIncart = cartController.getProductQuntitiyInCart(product.id);
        return Container(
        decoration: BoxDecoration(
          color:  productQuantityIncart >0 ?TColors.primary :TColors.dark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusMd),
            bottomRight: Radius.circular(TSizes.productImageRadius),
          ),
        ),
        child: SizedBox(
          width: TSizes.iconLg * 1.2,
          height: TSizes.iconLg * 1.2,
          child: Center(
            child:  Center(
              child: productQuantityIncart >0 
              ? Text(productQuantityIncart.toString(),style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.white))
              : Icon( Iconsax.add, color: TColors.white),
            )
          ),
        ),
      );
      })
    );
  }
}
