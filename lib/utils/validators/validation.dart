class TValidator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName alanını doldurmanız gerek';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta alanını doldurmanız gerek';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Geçersiz e-posta adresi';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre alanını doldurmanız gerek';
    }

    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalı';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Şifre en az bir büyük harf içermeli';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Şifre en az bir rakam içermeli';
    }

    if (!value.contains(RegExp(r'[!@#\$%\^&\*(),.?":{}|<>]'))) {
      return 'Şifre en az bir özel karakter içermeli';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefon numarası alanını doldurmanız gerek';
    }
    // final phoneRegExp = RegExp(r'^\d{10}$');

    //  if (!phoneRegExp.hasMatch(value)) {
    // return 'Geçersiz telefon numarası formatı (10 rakam gerekli)';
    // }
    return null;
  }
}
