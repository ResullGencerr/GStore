
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:e_commerce/utils/constants/enum.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';

class OrderModel{

final String id;
final String userId;
final OrderStatus status;
final double totalAmount;
final DateTime orderDate;
final String paymentMethod;
final AddressModel? address;
final DateTime? deliveryDate;
final List<CartItemModel> items;

OrderModel({
  required this.id,
  this.userId="",
  required this.status,
  required this.totalAmount,
  required this.orderDate,
  this.paymentMethod="Visa",
  this.address,
  this.deliveryDate,
  required this.items,
});

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate!=null ? THelperFunctions.getFormattedDate(deliveryDate!) : "";


  String get orderStatusText => status == OrderStatus.delivered
  ? "Teslim Edildi"
  : status == OrderStatus.shipped
  ? "Kargoya Verildi"
  : "Hazırlanıyor";


 Map<String, dynamic> toJson() {
  return {
    "Id": id,
    "UserId": userId,
    "Status": status.toString(),
    "TotalAmount": totalAmount,
    "OrderDate": orderDate,
    "PaymentMethod": paymentMethod,
    "Address": address?.toJson(),
    "DeliveryDate": deliveryDate,
    "Items": items.map((e) => e.toJson()).toList(),
  };
  }

   factory OrderModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return OrderModel(
      id: data["Id"] as String,
      userId: data["UserId"] as String,
      status: OrderStatus.values.firstWhere((e) => e.toString() == data["Status"]),
      totalAmount: (data["TotalAmount"] as num).toDouble(),
      orderDate: (data["OrderDate"] as Timestamp).toDate(),
      paymentMethod: data["PaymentMethod"]as String,
      address: AddressModel.fromMap(data["Address"] as Map<String, dynamic>),
      deliveryDate: data["DeliveryDate"] != null ? (data["DeliveryDate"] as Timestamp).toDate() : null,
      items: (data["Items"] as List<dynamic>).map((e) => CartItemModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
   }
 }
 





