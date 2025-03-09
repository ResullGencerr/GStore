import 'package:e_commerce/data/repositories/user/user_respository.dart';
import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRespository extends GetxController {
  static AuthenticationRespository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser; 
   if (user != null) {
      if (user.emailVerified) {
        await TLocalStorage.init(user.uid);
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {  
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read("IsFirstTime") != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }  
     FlutterNativeSplash.remove();
  }

/* ================================ Email & Password ================================= */

// Sign In

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
  try {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw 'Kullanıcı bulunamadı. Lütfen e-posta adresinizi kontrol edin.';
    } else if (e.code == 'wrong-password') {
      throw 'E-posta adresi veya şifre yanlış. Lütfen tekrar deneyin.';
    }
    else if (e.code == 'invalid-credential') {
      throw 'E-posta adresi veya şifre yanlış. Lütfen tekrar deneyin.';
    }
    throw 'Bir hata oluştu: ${e.message}';
  } catch (e) {
    throw 'Beklenmedik bir hata oluştu: $e';
  }
}


// Register
 Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
  try {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      throw 'Bu e-posta adresi zaten kullanılıyor. Lütfen başka bir e-posta deneyin.';
    }
    throw 'Bir hata oluştu: ${e.message}';
  } catch (e) {
    throw 'Beklenmedik bir hata oluştu: $e';
  }
}


 Future<void> sendEmailVerification() async {
  try {
    await _auth.currentUser?.sendEmailVerification();
  } on FirebaseAuthException catch (e) {
    throw 'E-posta doğrulama gönderilemedi: ${e.message}';
  } catch (e) {
    throw 'Beklenmedik bir hata oluştu: $e';
  }
}


Future<void> sendPasswordResetEmail(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw 'Bu e-posta adresiyle kayıtlı bir hesap bulunamadı.';
    }
    throw 'Bir hata oluştu: ${e.message}';
  } catch (e) {
    throw 'Beklenmedik bir hata oluştu: $e';
  }
}

  // Re Authenticate User

Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
  try {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    await _auth.currentUser!.reauthenticateWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'wrong-password') {
      throw 'E-posta veya şifre yanlış. Lütfen tekrar deneyin.';
    }
    throw 'Bir hata oluştu: ${e.message}';
  } catch (e) {
    throw 'Beklenmedik bir hata oluştu: $e';
  }
}


  // Delete User
 Future<void> deleteAccount() async {
  try {
    await UserRespository.instance.removeUserRecord(_auth.currentUser!.uid);
    await _auth.currentUser?.delete();
  } catch (e) {
    throw 'Hesap silinirken bir hata oluştu: $e';
  }
}


  //  Google Sign In

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) {
        print("Something went wrong: $e");
      }
      throw e;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      throw e;
    }
  }
}
