import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text("Sepetim", style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Obx((){

         if(controller.cartItems.isEmpty ){
         return TAnimationLoaderWidget(
          text: "Sepetiniz Boş",
         animation: TImages.cartAnimation
         );

         }else{
          return SingleChildScrollView(child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),child: TCartItems()));   
         }
          }
      ),
     bottomNavigationBar: controller.cartItems.isNotEmpty ? Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => CheckoutScreen()),
          child: Obx(()=> Text("Sepeti Onayla ${controller.totalCartPrice.value} TL")),
        ),
      ): SizedBox()
    );
  }
}
