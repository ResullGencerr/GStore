import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text("Yeni Adres Ekle"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      TValidator.validateEmptyText("İsim", value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: "İsim"),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) =>
                      TValidator.validateEmptyText("Telefon Numarası", value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      labelText: "Telefon Numarası"),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) =>
                            TValidator.validateEmptyText("Sokak", value),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            labelText: "Sokak"),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) =>
                            TValidator.validateEmptyText("Posta Kodu", value),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            labelText: "Posta Kodu"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) =>
                            TValidator.validateEmptyText("Şehir", value),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: "Şehir"),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            TValidator.validateEmptyText("İlçe", value),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.activity),
                            labelText: "İlçe"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>
                      TValidator.validateEmptyText("Ülke", value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.global), labelText: "Ülke"),
                ),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.addNewAddress(),
                        child: Text("Kaydet")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
