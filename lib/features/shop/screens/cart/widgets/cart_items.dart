import 'package:e_commerce/common/widgets/products/cart/add_remove_button.dart';
import 'package:e_commerce/common/widgets/products/cart/cart_item.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemobeButtons = true,
    
  });

  final bool showAddRemobeButtons;
  
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx((){
      return ListView.separated(  
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartController.cartItems.length,
      separatorBuilder: (context, index) => SizedBox(
        height: TSizes.spaceBtwSections,
      ),
      itemBuilder: (context, index) => Obx((){
          final item = cartController.cartItems[index];
          return Column(    
          children: [
            TCartItem(cartItem: item),
            if (showAddRemobeButtons) SizedBox(height: TSizes.spaceBtwItems),
            
            if (showAddRemobeButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Extra Space
                      SizedBox(width: 70),
                      // Add Remove Button
                      TProductQuantitiyWithAddRemove(cartItem: item,),
                    ],
                  ),
                  ProductPriceText(price: (item.price*item.quantity).toStringAsFixed(1) ),
                ],
              )
          ],
        );
        })
        
          );
    });
  }
}
