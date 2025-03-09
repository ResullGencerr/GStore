import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/data/repositories/user/user_respository.dart';
import 'package:e_commerce/features/authentication/models/user_model.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      // Start Loading

      TFullScreenLoader.openLoadingDialog(
          "Bilgileriniz işleniyor, lütfen bekleyin...", TImages.docerAnimation);

      // Check Internet Connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnacbar(
            title: "Gizlilik Politikasını Kabul Edin",
            message:
                "Hesap oluşturabilmek için Gizlilik Politikasını ve Kullanım Şartlarını okumanız ve kabul etmeniz gerekmektedir.");

        return;
      }

      // Register User in  the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRespository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: "",
      );

      final userRepository = Get.put(UserRespository());

      await userRepository.saveUserData(newUser);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Succes Message
      TLoaders.successSnackbar(
          title: "Tebrikler",
          message: "Hesabınız başarıyla oluşturuldu! Devam etmek için e-posta adresinizi doğrulayın.");

      // Move to verify Email Screen

      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: "Ohh Hayır!", message: e.toString());
    }
  }
}
