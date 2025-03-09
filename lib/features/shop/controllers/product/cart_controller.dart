 
import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:e_commerce/features/shop/models/products_model.dart';
import 'package:e_commerce/features/shop/screens/cart/cart.dart';
import 'package:e_commerce/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();



  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt addToCartCount = 0.obs;



  @override
  void onInit() {
    super.onInit();
    loadCartFromLocal();
  }



  void productDetailAddToCart(CartItemModel newItem, int quantity){
    if(quantity<1){
      TLoaders.customToast(message: "En az bir adet ürün eklenmelidir");
      return;
    }
    int index = cartItems.indexWhere((item) => item.productId == newItem.productId);

    if (index != -1) {
      cartItems[index].quantity += quantity;
      TLoaders.customToast(message: "Ürün başarıyla eklendi");
    } else {
      cartItems.add(newItem);   
         TLoaders.customToast(message: "Ürün başarıyla eklendi");
    }
    addToCartCount.value=0;
    updateCart();
  }

  







  /// **Sepete Ürün Ekleme ve Güncelleme**
  void addToCart(CartItemModel newItem) {
    int index = cartItems.indexWhere((item) => item.productId == newItem.productId);

    if (index != -1) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(newItem);
    }
    updateCart();
  }

    void addToCartAndCheackOut(CartItemModel newItem) {
    int index = cartItems.indexWhere((item) => item.productId == newItem.productId);

    if (index != -1) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(newItem);
    }
    Get.to(()=>CartScreen());
    updateCart();
  }
  


  void increaseQuantity(CartItemModel item) {
  int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId);
  if (index != -1) {
    cartItems[index].quantity += 1;
    updateCart();
    
  }
}

void decreaseQuantity(CartItemModel item) {
  int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId);
  if (index != -1) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity -= 1;
    } else {
      // Kullanıcıya onay diyaloğu göster
      cartItems[index].quantity == 1 ? removeFromCartDialog(index) :cartItems.removeAt(index);
    }
   updateCart();
  }
}


  /// **Sepeti Localde Kaydetme**
  Future<void> saveCartToLocal() async {
    
  final cartJsonList = cartItems.map((e) => e.toJson()).toList();
     TLocalStorage.instance().saveData("cartItems", cartJsonList);
  }

  /// **Sepeti Localden Yükleme**
  Future<void> loadCartFromLocal() async {
    final cartItemString = TLocalStorage.instance().readData<List<dynamic>>("cartItems");
   
    if (cartItemString != null) {
      cartItems.assignAll(cartItemString.map((json) => CartItemModel.fromJson(json)).toList());
      updateCart();
    }
  }


  int getProductQuntitiyInCart(String productId){
    final foundItem= cartItems.where((item)=>item.productId==productId).fold(0, (prevValue, element) => prevValue+element.quantity);
    return foundItem;
  }

 CartItemModel convertToCartItem(ProductsModel product, int quantity){

    final price =  (product.salePrice != null && product.salePrice! > 0) ? product.salePrice : product.price;
    return CartItemModel(
      productId: product.id,
      title: product.title??"",
      price: price??0.0,
      image: product.thumbnail??"",
      quantity: quantity,
      brandName: product.brand?.name??"",

    );

  }

  void updateCart(){
    updateTotalPrice();
    saveCartToLocal();
    cartItems.refresh();
  }


  /// **Sepetteki Toplam Ürün Fiyatı**
   
   void updateTotalPrice(){
    double calculateTotalPrice = 0.0;
    for (var item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
    }
    totalCartPrice.value = calculateTotalPrice;
   }
 



  /// **Toplam Sepet Ürün Sayısı**
  int get totalCartItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  void clearCart(){
    cartItems.clear();
    totalCartPrice.value = 0.0;
    addToCartCount.value = 0;
     totalCartPrice.refresh();
     addToCartCount.refresh();
     cartItems.refresh();
     saveCartToLocal() ;
    update();   
  }



  void removeFromCartDialog(int index){
    Get.defaultDialog(
      title:"Ürünü Kaldır",
      middleText: "Bu ürünü sepetten kaldırmak istediğinize emin misiniz?",
       textConfirm: "Evet",
      textCancel: "Hayır",
      onConfirm: (){
        cartItems.removeAt(index);
        updateCart();
        Get.back();
      },
      onCancel: () => ()=>Get.back(),
    );
  }
}


 
 




 
 
 
 

