import 'package:e_commerce/features/personalization/controllers/cupon_controller.dart';
import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final discountController = CuponController.instance;
    final productPrice = controller.totalCartPrice;
    return Obx((){
       return Column(
      children: [
        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Ara Toplam", style: Theme.of(context).textTheme.bodyMedium),
            Text("₺ $productPrice", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Kargo Bedeli", style: Theme.of(context).textTheme.bodyMedium),
            Text("₺ ${TPricingCalculator.calculateShippingCost(productPrice.toDouble(), "TR")}", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Vergi Bedeli", style: Theme.of(context).textTheme.bodyMedium),
            Text("₺ ${TPricingCalculator.calculateTax(productPrice.toDouble(), "TR")}", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
    
        if(discountController.discount.value!=0.0)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("İndirim", style: Theme.of(context).textTheme.bodyMedium),
            Text("₺ ${(productPrice*discountController.discount.value)/100}", style: Theme.of(context).textTheme.bodyMedium),
            
          ],
        ),
        if(discountController.discount.value!=0.0)
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        

        // Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Toplam", style: Theme.of(context).textTheme.bodyMedium),
            Text("₺ ${TPricingCalculator.calculateTotalPrice(productPrice.toDouble(), "TR", discount:((productPrice*discountController.discount.value)/100) )}", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
    });
  }
}
