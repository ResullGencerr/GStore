import 'package:e_commerce/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                  image: TImages.onBoardingImage1,
                  title: TTexts.onboardingTitle1,
                  subtitle: TTexts.onboardingSubtitle1),
              OnBoardingPage(
                  image: TImages.onBoardingImage2,
                  title: TTexts.onboardingTitle2,
                  subtitle: TTexts.onboardingSubtitle2),
              OnBoardingPage(
                  image: TImages.onBoardingImage3,
                  title: TTexts.onboardingTitle3,
                  subtitle: TTexts.onboardingSubtitle3),
            ],
          ),
          OnBoardingSkip(),
          OnBoardingDotNavigation(),
          OnBoardingNextButton()
        ],
      ),
    );
  }
}
