import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/custom_shapes/containers/primay_header_container.dart';
import 'package:e_commerce/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:e_commerce/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/features/personalization/controllers/settings/settings_controller.dart';
import 'package:e_commerce/features/personalization/screens/address/address.dart';
import 'package:e_commerce/features/personalization/screens/cupon/cupon.dart';
import 'package:e_commerce/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce/features/shop/screens/cart/cart.dart';
import 'package:e_commerce/features/shop/screens/order/order.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = SettingsController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Başlık
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      "Hesabım",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Kullanıcı Profil Kartı
                  TUserProfileTile(
                    onTap: () => Get.to(() => ProfileScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Hesap Ayarları
                  TSectionHeading(
                    title: "Hesap Ayarları",
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "Adreslerim",
                    subtitle: "Teslimat adreslerini yönet",
                    onTap: () => Get.to(() => UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "Sepetim",
                    subtitle: "Ürünleri ekleyin, çıkarın ve ödeme adımına geçin",
                    onTap: () => Get.to(() => CartScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: "Siparişlerim",
                    subtitle: "Devam eden ve tamamlanan siparişleri görüntüleyin",
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  
                  TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: "Kuponlarım",
                    subtitle: "Mevcut indirim kuponlarını görüntüleyin",
                    onTap: () => Get.to(() => CuponScreen()),
                  ),
                 
                

                  // Uygulama Ayarları
                  const SizedBox(height: TSizes.defaultSpace),
                  
                   TSectionHeading(
                    title: "Uygulama Ayarları",
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
      
                  Obx(()=> Column(
                    children: [
                      TSettingsMenuTile(
                      icon: Iconsax.location,
                      title: "Tema Rengi",
                      subtitle: "Tema Rengini Değiştirin ",
                      trailing: Switch(value: settingsController.isDarkMode, onChanged: (value) { settingsController.toggleTheme(value);}),
                       ),
                      TSettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: "Bildirimler",
                      subtitle: "Bildirimleri Açmak İçin Tıklayın",
                      trailing: Switch(value: settingsController.notification.value, onChanged: (value) { settingsController.toggleNotification(value);})
                      ),
                    ],
                  ),
                    ),
                  
                
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Çıkış Yap Butonu
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRespository.instance.logout(),
                        child: const Text("Çıkış Yap")),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
