import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final _storage = GetStorage();
  late final RxBool _isDarkMode;
  RxBool notification = false.obs;

  @override
  void onInit() {
    super.onInit();
    _isDarkMode = RxBool(_storage.read('isDarkMode') ?? false);
    notification= RxBool(_storage.read('notification') ?? false);
  }

  bool get isDarkMode => _isDarkMode.value;

  void toggleTheme(bool isDark) {
    _isDarkMode.value = isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    _storage.write('isDarkMode', isDark);
  }
  void toggleNotification(bool isNotification){
    notification.value = isNotification;
    _storage.write('notification', isNotification);
    if(isNotification){
     TLoaders.customToast(message: "Bildirimler Açık");
    }else{
      TLoaders.customToast(message: "Bildirimler Kapalı");
    }
  }
}
