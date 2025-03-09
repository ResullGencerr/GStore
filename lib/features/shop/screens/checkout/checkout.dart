import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/common/widgets/products/cart/coupon_widget.dart';
import 'package:e_commerce/features/personalization/controllers/cupon_controller.dart';
import 'package:e_commerce/features/personalization/controllers/order_controller.dart';
import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/billing_paymet_section.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:e_commerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final orderController = OrderController.instance;
    final disCountController = CuponController.instance;
    final subTotal = cartController.totalCartPrice.value;

     WidgetsBinding.instance.addPostFrameCallback((_) {
      disCountController.clearCupon(); 
    });
    return Scaffold(
      appBar: TAppBar(
        title: Text("Sipariş Özeti",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Items in Cart
              TCartItems(showAddRemobeButtons: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Coupon TextField
              TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Billing Section
              TRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? TColors.dark : TColors.white,
                padding: EdgeInsets.all(TSizes.md),
                child: Column(
                  children: [
                    // Pricing
                    TBillingAmountSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Payment Methods
                    TBillingPaymetSection(),
                    // Address
                    TBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal >0
          ? (){
            final cartItems = cartController.cartItems.toList();
            orderController.processOrder(TPricingCalculator.calculateTotalPrice(cartController.totalCartPrice.value, "TR"), cartItems);
            cartController.clearCart();    
          }
          : ()=> TLoaders.warningSnacbar(title: "Sipariş Boş", message: "Lütfen ürün eklemeyi ve ödeme yöntemini seçiniz"),
          child: Obx(()=>Text("Satin Al  ₺ ${TPricingCalculator.calculateTotalPrice(cartController.totalCartPrice.value, "TR" ,discount: ((cartController.totalCartPrice.value*disCountController.discount.value)/100))}")),
        ),
      ),
    );
  }
}
