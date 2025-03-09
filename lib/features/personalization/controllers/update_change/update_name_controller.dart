import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/user/user_respository.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();
  final userController = UserController.instance;
  final userRespository = Get.put(UserRespository());

  @override
  void onInit() {
    super.onInit();
    initializeName();
  }

  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateFirstAndLastName() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "We are updating your information...", TImages.docerAnimation);

      // Check Internet Connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        "FirstName": firstName.text.trim(),
        "LastName": lastName.text.trim()
      };
      await userRespository.updateSingleField(name);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackbar(
          title: "Congratulations",
          message: "Your name has been updated successfully");

      Get.off(() => ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: "Oh Snap!", message: e.toString());
    }
  }
}
