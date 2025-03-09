import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_respository.dart';
import 'package:e_commerce/features/authentication/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRespository extends GetxController {
  static UserRespository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save User Data in the Firebase Firestore

  Future<void> saveUserData(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  // Fetch User Details from the Firebase Firestore

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRespository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  // Update User Details in the Firebase Firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  // Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRespository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  // Delete User  from the Firebase Firestore

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  // Upload any Image

  Future<String> uploadImage(String imagePath, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(imagePath).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }
}
