import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
  

    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
            title: "Adres", buttonTitle: "Değiştir", onPressed: ()=>addressController.selectNewAddressPopup(context)),
            addressController.selectedAddress.value.id.isNotEmpty?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(addressController.selectedAddress.value.name, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            Icon(Icons.phone, color: Colors.grey, size: 16),
            SizedBox(width: TSizes.spaceBtwItems),
            Text(TFormatter.formatPhoneNumber(addressController.selectedAddress.value.phoneNumber),
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            Icon(Icons.location_history, color: Colors.grey, size: 16),
            SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
                child: Text(
                 "${addressController.selectedAddress.value.street}, ${addressController.selectedAddress.value.city}, ${addressController.selectedAddress.value.state}, ${addressController.selectedAddress.value.postalCode}, ${addressController.selectedAddress.value.country}",
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            )),
          ],
        ),
          ],
        )
        : Text("Yeni Adres Ekle", style: Theme.of(context).textTheme.bodyMedium),
       
      ],
    ),);
  }
}
