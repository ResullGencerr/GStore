import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/common/widgets/success_screen/succes_screen.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    // setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRespository.instance.sendEmailVerification();
      TLoaders.successSnackbar(
    title: "E-posta Gönderildi",
    message: "Lütfen gelen kutunuzu kontrol edin ve e-posta adresinizi doğrulayın.");
    } catch (e) {
      TLoaders.warningSnacbar(title: "E-posta Gönderildi", message:"Lütfen gelen kutunuzu kontrol edin ve e-posta adresinizi doğrulayın.");
    }
  }

  // setTimerForAutoRedirect() {
  //   Timer.periodic(
  //     const Duration(seconds: 1),
  //     (timer) async {
  //       await FirebaseAuth.instance.currentUser?.reload();
  //       final user = FirebaseAuth.instance.currentUser;
  //       if (user?.emailVerified ?? false) {
  //         timer.cancel();
  //         Get.off(() => SuccesScreen(
  //             image: TImages.successfullyRegisterAnimation,
  //             title: TTexts.yourAccountCreatedTitle,
  //             subTitle: TTexts.yourAccountCreatedSubTitle,
  //             onPressed: () =>
  //                 AuthenticationRespository.instance.screenRedirect()));
  //       }
  //     },
  //   );
  // }

  logout() async {
    try {
      await AuthenticationRespository.instance.logout();
      await AuthenticationRespository.instance.screenRedirect();
    } catch (e) {
      throw e;
    }
  }

  checkEmailVerificationStatus() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccesScreen(
          image: TImages.successfullyRegisterAnimation,
          title: TTexts.yourAccountCreatedTitle,
          subTitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () =>
              AuthenticationRespository.instance.screenRedirect()));
    } else {
      TLoaders.errorSnackbar(
          title: "Ohh Hayır!", message: "E-posta adresinizi doğrulamanız gerekmektedir");
    }
  }
}
