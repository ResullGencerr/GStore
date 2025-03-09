import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/features/personalization/controllers/cupon_controller.dart';
import 'package:e_commerce/features/personalization/models/cupons_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TCuponCardWidget extends StatelessWidget {
  const TCuponCardWidget({
    super.key,
    required this.cupon,
  });
  final CuponModel cupon;
  @override
  Widget build(BuildContext context) {
    final controller = CuponController.instance;
    return TRoundedContainer(
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.all(TSizes.lg),
      backgroundColor: TColors.primary.withOpacity(0.6),
      child: Row(children: [
        Expanded(flex: 1, child: Text("${cupon.discount!.floor()}%", style: Theme.of(context).textTheme.headlineLarge)),
        const SizedBox(width: TSizes.spaceBtwItems),
        Expanded(
          flex:3 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cupon.name!, style: Theme.of(context).textTheme.titleMedium , maxLines: 2, overflow: TextOverflow.ellipsis,),
              
              Row(children: [
                Text("Kupon Kodu: ", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(width: TSizes.spaceBtwItems/4),
                Text(cupon.cuponCode!, style: Theme.of(context).textTheme.titleLarge),
               
               Expanded(child:  IconButton(onPressed:()=>controller.copyCuponCode(cupon.cuponCode!) , icon: Icon(Iconsax.copy, size: TSizes.iconSm, color: TColors.black)))
              ],)
            ],
          ),
        )
      ],),
    );
  }
}