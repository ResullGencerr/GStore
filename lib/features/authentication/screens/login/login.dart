import 'package:e_commerce/common/styles/spacing_style.dart';
import 'package:e_commerce/common/widgets/login_signup/form_divider.dart';
import 'package:e_commerce/common/widgets/login_signup/social_buttons.dart';

import 'package:e_commerce/features/authentication/screens/login/widgets/login_form.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/login_header.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithappBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo, Title, Subtitle
              TLoginHeader(),

              // Form
              TLoginForm(),

              /// Divider
              TFormDivider(dividerText: TTexts.orSignInWith),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Footer
              TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
