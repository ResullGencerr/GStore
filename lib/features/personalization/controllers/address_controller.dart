import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/data/repositories/address/address_respository.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/features/personalization/screens/address/add_new_address.dart';
import 'package:e_commerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final postalCode = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final addressRepository = Get.put(AddressRespository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere((e) => e.selectedAddres,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      TLoaders.errorSnackbar(title: "Addres Bulunamadi", message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateAddress(selectedAddress.value.id, false);
      }
      newSelectedAddress.selectedAddres = true;
      selectedAddress.value = newSelectedAddress;
      await addressRepository.updateAddress(newSelectedAddress.id, true);  
      selectedAddress.refresh();

    } catch (e) {
      TLoaders.errorSnackbar(title: "Adres Bulunamadi", message: e.toString());
    }
  }

  Future addNewAddress() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Adres Ekleniyor", TImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: "",
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddres: true,
      );
      final id = await addressRepository.createNewAddress(address);

      address.id = id;
      await selectAddress(address);
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackbar(
          title: "Başarılı", message: "Adres başarıyla eklendi");

      refreshData.toggle();

      clearForm();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TLoaders.errorSnackbar(title: "Adres Eklenemedi", message: e.toString());
    }
  }

    Future<dynamic> selectNewAddressPopup(BuildContext context){
      return showModalBottomSheet(context: context, builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(TSizes.lg),
          child: Column(
            children: [
              TSectionHeading(title: "Adresinizi Seçin", showActionButton: false),
              FutureBuilder(future: allUserAddresses(), builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return SizedBox(
                    height: THelperFunctions.screenHeight()/2,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => TSingleAddress(address: snapshot.data![index],
                   onTap: ()async {
                    await selectAddress(snapshot.data![index]);
                    Get.back();
                   }    
                   ),
                );
              },  
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: ()=>Get.to(()=>AddNewAddressScreen()), child: const Text("Yeni Adres Ekle")),
              )
            ],
          )
        
        ),
      ));
    }









  void clearForm() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    city.clear();
    state.clear();
    postalCode.clear();
    country.clear();
    addressFormKey.currentState?.reset();
    update();
  }
}
