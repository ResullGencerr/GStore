import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final localStorage = GetStorage();
  final remmerberMe = false.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read("REMMER_ME_EMAİL") ?? "";
    password.text = localStorage.read("REMMER_ME_PASSWORD") ?? "";
    super.onInit();
  }

  // Email And Password Signin
  Future<void> emailAndPasswordSignin() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Hesabınıza Giriş Yapılıyor..", TImages.docerAnimation);

      // Check Internet Connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Remember me
      if (remmerberMe.value) {
        localStorage.write("REMMER_ME_EMAİL", email.text.trim());
        localStorage.write("REMMER_ME_PASSWORD", password.text.trim());
      }

      // Login User Email and Password
      await AuthenticationRespository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      TFullScreenLoader.stopLoading();

      AuthenticationRespository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: "Ohh Hayir!", message: e.toString());
    }
  }

  // Google Sign In
  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Google Hesabiniza Giriş Yapılıyor..", TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredential =
          await AuthenticationRespository.instance.signInWithGoogle();

      await userController.saveUserRecord(userCredential);
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TLoaders.errorSnackbar(title: "Ohh Hayir!", message: e.toString());
    }
  }
}
