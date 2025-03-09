import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text_strings.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthebticateUserLoginForm extends StatelessWidget {
  const ReAuthebticateUserLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text("Kullanıcıyı Yeniden Doğrula"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              children: [
                // Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: (value) => TValidator.validateEmail(value),
                  decoration: const InputDecoration(
                    labelText: TTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        TValidator.validateEmptyText("Sifre", value),
                    decoration: InputDecoration(
                      labelText: TTexts.password,
                      prefixIcon: Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.reAuthenticateEmailAndPassword(),
                      child: Text(TTexts.verify)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
