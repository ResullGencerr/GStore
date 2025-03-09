import 'package:e_commerce/common/widgets/images/t_circular_image.dart';
import 'package:e_commerce/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: Obx(() {
        return controller.imageUploading.value
            ? TShimmerEffect(width: 60, height: 60, radius: 60)
            : TCircularImage(
                image: controller.user.value.profilePicture.isNotEmpty
                    ? controller.user.value.profilePicture
                    : TImages.userProfileImage,
                width: 60,
                height: 60,
                padding: 0,
                isNetworkImage: controller.user.value.profilePicture.isNotEmpty,
              );
      }),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
        onPressed: onTap,
        icon: Icon(
          Iconsax.edit,
          color: TColors.white,
        ),
      ),
    );
  }
}
