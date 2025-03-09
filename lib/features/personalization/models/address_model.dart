import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  String name;
  String phoneNumber;
  String street;
  String city;
  String state;
  String postalCode;
  String country;
  final DateTime? dateTime;
  bool selectedAddres;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddres = true,
  });

  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
      id: "",
      name: "",
      phoneNumber: "",
      street: "",
      city: "",
      state: "",
      postalCode: "",
      country: "");

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Name": name,
      "PhoneNumber": phoneNumber,
      "Street": street,
      "City": city,
      "State": state,
      "PostalCode": postalCode,
      "Country": country,
      "DateTime": DateTime.now(),
      "SelectedAddres": selectedAddres,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> json) {
    return AddressModel(
      id: json["Id"] as String,
      name: json["Name"] as String,
      phoneNumber: json["PhoneNumber"] as String,
      street: json["Street"] as String,
      city: json["City"] as String,
      state: json["State"] as String,
      postalCode: json["PostalCode"] as String,
      country: json["Country"] as String,
      dateTime: (json["DateTime"] as Timestamp).toDate(),
      selectedAddres: json["SelectedAddres"] as bool,
    );
  }
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return AddressModel(
      id: document.id,
      name: data["Name"] ?? "",
      phoneNumber: data["PhoneNumber"] ?? "",
      street: data["Street"] ?? "",
      city: data["City"] ?? "",
      state: data["State"] ?? "",
      postalCode: data["PostalCode"] ?? "",
      country: data["Country"] ?? "",
      dateTime: (data["DateTime"] as Timestamp).toDate(),
      selectedAddres: data["SelectedAddres"] as bool,
    );
  }

  @override
  String toString() {
    return "$street, $city, $state, $postalCode, $country";
  }
}
