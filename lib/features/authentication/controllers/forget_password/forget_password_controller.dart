import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "İşleminiz Gerçekleştiriliyor..", TImages.docerAnimation);

      // Check Internet Connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRespository.instance
          .sendPasswordResetEmail(email.text.trim());

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackbar(
          title: "E-posta Gönderildi",
          message: "Şifrenizi sıfırlamak için e-posta bağlantısı gönderildi");
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: "Ohh Hayır!", message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "İşleminiz Gerçekleştiriliyor..", TImages.docerAnimation);

      // Check Internet Connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRespository.instance.sendPasswordResetEmail(email);

      TFullScreenLoader.stopLoading();
        TLoaders.successSnackbar(
          title: "E-posta Gönderildi",
          message: "Şifrenizi sıfırlamak için e-posta bağlantısı gönderildi");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: "Ohh Hayır!", message: e.toString());
    }
  }
}
