import 'package:e_commerce/bindings/general_bindings.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/features/personalization/controllers/settings/settings_controller.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRespository()));


  runApp(App( ));
}

class App extends StatelessWidget {
  const App({super.key ,});
 
  @override
  Widget build(BuildContext context) {
    final themeController =  Get.put(SettingsController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialBinding: GeneralBindings(),
      theme: TAppTheme.lightTheme,
      getPages: AppRoutes.pages,
      darkTheme: TAppTheme.darkTheme,
    );
  }
}
