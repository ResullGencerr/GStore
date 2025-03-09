import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:e_commerce/features/authentication/screens/signup/signup.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/features/personalization/screens/address/address.dart';
import 'package:e_commerce/features/personalization/screens/cupon/cupon.dart';
import 'package:e_commerce/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce/features/personalization/screens/settings/settings.dart';
import 'package:e_commerce/features/shop/screens/cart/cart.dart';
import 'package:e_commerce/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce/features/shop/screens/home/home.dart';
import 'package:e_commerce/features/shop/screens/order/order.dart';
import 'package:e_commerce/features/shop/screens/product_details/product_detail.dart';
import 'package:e_commerce/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:e_commerce/features/shop/screens/store/store.dart';
import 'package:e_commerce/features/shop/screens/wishlist/wishlist.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favorites, page: () => const FavoritesScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    GetPage(
        name: TRoutes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(
        name: TRoutes.productDetail, page: () => const ProductDetailScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: TRoutes.forgotPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnboardingScreen()),
    GetPage(name: TRoutes.cupon, page: () => const CuponScreen()),
  ];
}
