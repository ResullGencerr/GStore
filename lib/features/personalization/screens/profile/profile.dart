import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/images/t_circular_image.dart';
import 'package:e_commerce/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:e_commerce/features/personalization/screens/profile_update_change/change_name.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Profil"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Profil Resmi
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        return controller.imageUploading.value
                            ? TShimmerEffect(width: 80, height: 80, radius: 80)
                            : TCircularImage(
                                image: controller
                                        .user.value.profilePicture.isNotEmpty
                                    ? controller.user.value.profilePicture
                                    : TImages.userProfileImage,
                                width: 80,
                                height: 80,
                                padding: 0,
                                isNetworkImage: controller
                                    .user.value.profilePicture.isNotEmpty,
                              );
                      },
                    ),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: Text("Profil Resmini Değiştir")),
                  ],
                ),
              ),

              // Detaylar
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSectionHeading(
                  title: "Profil Bilgileri", showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: "Ad Soyad",
                  value: controller.user.value.fullName,
                  onTap: () => Get.off(() => ChangeNameScreen())),
              TProfileMenu(
                  title: "Kullanıcı Adı",
                  value: controller.user.value.username,
                  onTap: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              TSectionHeading(
                title: "Kişisel Bilgiler",
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                  title: "Kullanıcı ID",
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                  onTap: () {}),
              TProfileMenu(
                  title: "E-posta",
                  value: controller.user.value.email,
                  onTap: () {}),
              TProfileMenu(
                  title: "Telefon",
                  value: controller.user.value.phoneNumber,
                  onTap: () {}),
              TProfileMenu(title: "Cinsiyet", value: "Erkek", onTap: () {}),
              TProfileMenu(
                  title: "Doğum Tarihi", value: "01/01/1990", onTap: () {}),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: Text(
                    "Hesabı Sil",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
