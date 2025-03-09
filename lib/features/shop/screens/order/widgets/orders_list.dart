
import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/features/personalization/controllers/order_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TOrderListItem extends StatelessWidget {
  const TOrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = OrderController.instance;
    return FutureBuilder(future:controller.fetchUserOrders() , builder: (context, snapshot) {
      
      if(snapshot.connectionState == ConnectionState.waiting){
        return SizedBox(
          height: THelperFunctions.screenHeight()/2,
          child: Center(child: CircularProgressIndicator.adaptive()),
        );
      }
      if(snapshot.hasError){
        print("hatam ${snapshot.error.toString()}");
        TLoaders.errorSnackbar(title: "Sipariş Bulunamadı", message: snapshot.error.toString());
          return Center(child: Text("Bir hata oluştu"));
      }
    
      if(snapshot.data!.isEmpty){
        return TAnimationLoaderWidget(
          text: "Sipariş Bulunamadı",
          animation: TImages.orderCompletedAnimation,
        );
      }else{
         final orders = snapshot.data!;      
          return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
              height: TSizes.spaceBtwItems,
            ),
        itemCount: orders.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {      
          final order = orders[index];
          return TRoundedContainer(
            showBorder: true,
            backgroundColor: dark ? TColors.dark : TColors.light,
            padding: EdgeInsets.all(TSizes.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row 1
                Row(
                  children: [
                    // 1- Icon
                    Icon(Iconsax.ship),
                    SizedBox(width: TSizes.spaceBtwItems / 2),

                    // 2- Status and Date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(order.orderStatusText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                      color: TColors.primary,
                                      fontWeightDelta: 1)),
                          Text(order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall)
                        ],
                      ),
                    ),
                    // 3- Icon
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Iconsax.arrow_right_34,
                        size: TSizes.iconSm,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                // Row 2
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          // 1- Icon
                          Icon(Iconsax.tag),
                          SizedBox(width: TSizes.spaceBtwItems / 2),
                          // 2- Status and Date
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Siparis Kodu",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                Text(order.id,
                                    style:
                                        Theme.of(context).textTheme.titleMedium)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          // 1- Icon
                          Icon(Iconsax.calendar),
                          SizedBox(width: TSizes.spaceBtwItems / 2),
                          // 2- Status and Date
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Gönderim Tarihi",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                Text(order.formattedDeliveryDate,
                                    style:
                                        Theme.of(context).textTheme.titleMedium)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
      }

    },
    );
  }
}
