import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/features/personalization/controllers/update_change/update_name_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text_strings.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Adınızı Güncelleyin",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Heading

              Text(
                  "Kolay doğrulama için gerçek adınızı kullanın. Bu isim birkaç sayfada görünecektir.",
                  style: Theme.of(context).textTheme.labelMedium),

              const SizedBox(height: TSizes.spaceBtwSections),

              Form(
                key: controller.updateNameFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        controller: controller.firstName,
                        validator: (value) =>
                            TValidator.validateEmptyText("Ad", value),
                        expands: false,
                        decoration: InputDecoration(
                          labelText: TTexts.firstName,
                          prefixIcon: Icon(Iconsax.user),
                        )),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                        controller: controller.lastName,
                        expands: false,
                        validator: (value) =>
                            TValidator.validateEmptyText("Soyad", value),
                        decoration: InputDecoration(
                          labelText: TTexts.lastName,
                          prefixIcon: Icon(Iconsax.user),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Save Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.updateFirstAndLastName(),
                    child: Text("Kaydet")),
              ),
            ],
          )),
    );
  }
}
