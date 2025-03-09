import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/data/repositories/user/user_respository.dart';
import 'package:e_commerce/features/authentication/models/user_model.dart';
import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/features/personalization/screens/profile/re_authebticate_user_login_form.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRespository = Get.put(UserRespository());

  Rx<UserModel> user = UserModel.empty().obs;
  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch User Record

  Future<void> fetchUserRecord() async {
    try {
      final user = await userRespository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final nameParts =
            UserModel.nameParts(userCredential.user!.displayName ?? "");
        final usernName =
            UserModel.generateUsername(userCredential.user!.displayName ?? "");

        final user = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : '',
          username: usernName,
          email: userCredential.user!.email ?? "",
          phoneNumber: userCredential.user!.phoneNumber ?? "",
          profilePicture: userCredential.user!.photoURL ?? "",
        );

        await userRespository.saveUserData(user);
      }
    } catch (e) {
      TLoaders.warningSnacbar(
          title: "Data not saved",
          message:
              "Something went wrong while saving your information. You can re-save your data in your Profile.");
    }
  }

  // Delete Account Warnig

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSizes.md),
      title: "Hesap Silme",
      middleText:
         "Hesabınızı kalıcı olarak silmek istediğinizden emin misiniz? Bu işlem geri alınamaz ve tüm verileriniz kalıcı olarak silinecektir.",
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, side: BorderSide(color: Colors.red)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text("Hesabı Sil"),
        ),
      ),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: Text("İptal")),
    );
  }

  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog("İşlem Devam Ediyor...", TImages.docerAnimation);

      final auth = AuthenticationRespository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == "google.com") {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => LoginScreen());
        } else if (provider == "password") {
          TFullScreenLoader.stopLoading();
          Get.to(() => ReAuthebticateUserLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
     TLoaders.errorSnackbar(title: "Ohh Hayır!", message:"Hesap silme işlemi sırasında bir hata oluştu.");
    }
  }

  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      TFullScreenLoader.openLoadingDialog("İşlem Devam Ediyor...", TImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRespository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRespository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: "Ohh Hayır!", message:"Hesap silme işlemi sırasında bir hata oluştu.");
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        imageUploading.value = true;
        // Upload Image
        final imageUrl =
            await userRespository.uploadImage("Users/Images/Profile/", image);

        // Update User Image Record

        Map<String, dynamic> json = {
          "ProfilePicture": imageUrl,
        };
        await userRespository.updateSingleField(json);

        user.value.profilePicture = imageUrl.toString();
       TLoaders.successSnackbar(
          title: "Tebrikler",
          message: "Profil Resminiz başarıyla güncellendi!"
                                                            );
      }
    } catch (e) {
      TLoaders.errorSnackbar(
          title: "Ohh Hayır!", message: "Profil Resminizi Değiştirirken Bir Hata Oluştu: ");
    } finally {
      imageUploading.value = false;
    }
  }
}
