import 'package:e_commerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce/features/personalization/controllers/cupon_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';

class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = CuponController.instance;
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      padding: EdgeInsets.only(
          top: TSizes.sm, bottom: TSizes.sm, right: TSizes.sm, left: TSizes.md),
      child: Row(
        children: [
          Expanded(
            child: Form(
              key: controller.cuponFormKey,
              child: TextFormField(
                controller: controller.cupon,
                validator: (value) => TValidator.validateEmptyText("Kupon", value),
              decoration: InputDecoration(
                hintText: "Promosyon kodunuz mu var? Buraya girin",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),)
          ),

          // Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: dark
                      ? TColors.white.withOpacity(0.5)
                      : TColors.dark.withOpacity(0.5),
                  backgroundColor: TColors.primary.withOpacity(0.3),
                  side: BorderSide(color: Colors.grey.withOpacity(0.1)),
                ),
                onPressed: ()=> controller.applyCuponCode(controller.cupon.text.trim()),
                child: Text("Uygula")),
          )
        ],
      ),
    );
  }
}
