import 'package:e_commerce/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:e_commerce/features/authentication/screens/signup/signup.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text_strings.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            ///Password
            Obx(
              () => TextFormField(
                validator: (value) =>
                    TValidator.validateEmptyText("Şifre", value),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Remember me and forgot password

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.remmerberMe.value,
                        onChanged: (value) => controller.remmerberMe.value =
                            !controller.remmerberMe.value,
                      ),
                    ),
                    Text(TTexts.rememberMe),
                  ],
                ),

                /// Forgot password

                TextButton(
                    onPressed: () => Get.to(() => ForgetPasswordScreen()),
                    child: Text(TTexts.forgotPassword))
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Sign in button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordSignin(),
                    child: Text(TTexts.signIn))),

            const SizedBox(height: TSizes.spaceBtwItems),

            /// Create Account Button

            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => SignupScreen()),
                    child: Text(TTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
