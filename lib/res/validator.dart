import 'app_string.dart';

/// **Validation Utility Class**
/// Provides consistent validation logic throughout the app.
class Validators {
  /// **Checks if a string is null or empty after trimming.**
  static bool _isEmpty(String? value) => value?.trim().isEmpty ?? true;

  /// **Predefined regex patterns for validation.**
  static final RegExp _emailPattern =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp _namePattern = RegExp(r'^[a-zA-Z\s]+$');

  /// **Validates an email address.**
  static String? validateEmail(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyEmail;
    if (!_emailPattern.hasMatch(trimmedValue!)) {
      return AppString.invalidEmailFormat;
    }
    return trimmedValue.length > 320 ? AppString.emailTooLong : null;
  }

  /// **Validates a password.**
  static String? validatePassword(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyPassword;
    if (trimmedValue!.length < 6) return AppString.passwordTooShort;
    if (!trimmedValue.contains(RegExp(r'[A-Z]'))) {
      return AppString.passwordUppercase;
    }
    if (!trimmedValue.contains(RegExp(r'[a-z]'))) {
      return AppString.passwordLowercase;
    }
    if (!trimmedValue.contains(RegExp(r'\d'))) return AppString.passwordNumber;
    return trimmedValue.length > 20 ? AppString.passwordTooLong : null;
  }

  /// **Validates confirm password.**
  static String? validateConfirmPassword(String? value, String password) {
    return _isEmpty(value)
        ? AppString.confirmPasswordRequired
        : (value!.trim() != password ? AppString.passwordMismatch : null);
  }

  /// **Validates a name (only letters & spaces).**
  static String? validateName(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyName;
    if (trimmedValue!.length < 2) return AppString.nameTooShort;
    if (trimmedValue.length > 50) return AppString.nameTooLong;
    return _namePattern.hasMatch(trimmedValue) ? null : AppString.nameInvalid;
  }

  /// *** Validation a Phone Number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final trimedValue = value.trim();

    final phoneRegExp = RegExp(r'^(1)[0-9]{9}$');
    if (!phoneRegExp.hasMatch(trimedValue)) {
      return 'Enter a valid  phone number without 0 (e.g., 1712345678)';
    }
    return null;
  }
}
