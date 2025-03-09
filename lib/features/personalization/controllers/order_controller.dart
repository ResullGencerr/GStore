
import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/common/widgets/success_screen/succes_screen.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/data/repositories/order/order_repository.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/personalization/models/order_model.dart';
import 'package:e_commerce/features/shop/controllers/product/checkout_controller.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/enum.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();

  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  RxList<OrderModel> orders = <OrderModel>[].obs;

  

  Future<List<OrderModel>> fetchUserOrders() async{
    try {
      final fetchOrder = await orderRepository.fetchUserOders();
      print("orders $orders");
      orders.assignAll(fetchOrder);
      return fetchOrder;  
    } catch (e) {
      TLoaders.warningSnacbar(title: "Sipariş Bulunamadı", message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount, List<CartItemModel> cartItem) async{
    try {
      TFullScreenLoader.openLoadingDialog("Sipariş işlemi için lütfen bekleyiniz", TImages.pencilAnimation);
      final userId= AuthenticationRespository.instance.authUser!.uid;
      if(userId.isEmpty) return;


      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartItem.toList(),
      );
      await orderRepository.saveOrder(order, userId);
  

      Get.offAll(()=> SuccesScreen(
        image: TImages.orderCompletedAnimation,
       title: "Ödeme Başarılı!", 
       subTitle: "Siparişiniz yakında kargoya verilecektir.", 
       onPressed: ()=> Get.offAll(()=> NavigationMenu()),
       ),
       );
    } catch (e) {
      TLoaders.warningSnacbar(title: "Sipariş İşlemi Başarısız Oldu", message: e.toString());
    }
  }
  
}