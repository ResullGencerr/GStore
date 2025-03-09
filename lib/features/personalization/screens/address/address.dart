import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/personalization/screens/address/add_new_address.dart';
import 'package:e_commerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        child: Icon(Iconsax.add, color: TColors.white),
        backgroundColor: TColors.primary,
      ),
      appBar: TAppBar(
        title: Text(
          "Adreslerim",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(
              () => FutureBuilder(    
                key: Key(controller.refreshData.value.toString()),
                future: controller.allUserAddresses(),
                builder: (context, snapshot) {
                   if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: THelperFunctions.screenHeight()/2,
                      child: Center(child: CircularProgressIndicator.adaptive()),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return TAnimationLoaderWidget(
                    text: "Henüz eklediğiniz bir adres bulunmamaktadır.",
                    animation: TImages.pencilAnimation,
                  );
                }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => TSingleAddress(
                      address: snapshot.data![index],
                      onTap: () =>
                          controller.selectAddress(snapshot.data![index]),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
