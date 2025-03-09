import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  // Helper functions to get the full name

  String get fullName => '$firstName $lastName';

  // Helper functions to format the phone number
  String get phoneNumberFormatted => TFormatter.formatPhoneNumber(phoneNumber);

  // Static functions to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(' ');

  // Static functions to genarate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";

    return usernameWithPrefix;
  }

  // Static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  // Convert model to Json structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      "FirstName": firstName,
      "LastName": lastName,
      "UserName": username,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "ProfilePicture": profilePicture,
    };
  }

// Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    }
    return UserModel.empty();
  }
}
