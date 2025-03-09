
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/personalization/controllers/cupon_controller.dart';
import 'package:e_commerce/features/personalization/controllers/order_controller.dart';

import 'package:e_commerce/features/shop/controllers/product/checkout_controller.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(OrderController());
    Get.put(CuponController()); 
    
  }
}
