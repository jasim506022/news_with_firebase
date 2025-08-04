import 'app_string.dart';

/// **Validation Utility Class**
/// Provides consistent validation logic throughout the app.
class Validators {
  /// **Checks if a string is null or empty after trimming.**
  static bool _isEmpty(String? value) => value?.trim().isEmpty ?? true;

  /// **Predefined regex patterns for validation.**
  static final RegExp _emailPattern =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp _namePattern = RegExp(r'^[a-zA-Z\s]+$');

  /// Validates the given [email].
  /// Returns an error message string if invalid; otherwise, returns null.
  static String? validateEmail(String? email) {
    final trimmedEmail = email?.trim();
    if (_isEmpty(trimmedEmail)) return AppString.emptyEmail;
    if (!_emailPattern.hasMatch(trimmedEmail!)) {
      return AppString.invalidEmailFormat;
    }
    return trimmedEmail.length > 320 ? AppString.emailTooLong : null;
  }

  /// Validates the given [password] based on the following rules:
  /// - Must not be empty
  /// - Must be 6 to 20 characters long
  /// - Must include at least one uppercase letter
  /// - Must include at least one lowercase letter
  /// - Must include at least one number
  ///
  /// Returns an error message if validation fails, otherwise returns null.
  static String? validatePassword(String? password) {
    final trimmedPassword = password?.trim();
    if (_isEmpty(trimmedPassword)) return AppString.emptyPassword;
    if (trimmedPassword!.length < 6) return AppString.passwordTooShort;
    if (!trimmedPassword.contains(RegExp(r'[A-Z]'))) {
      return AppString.passwordUppercase;
    }
    if (!trimmedPassword.contains(RegExp(r'[a-z]'))) {
      return AppString.passwordLowercase;
    }
    if (!trimmedPassword.contains(RegExp(r'\d'))) {
      return AppString.passwordNumber;
    }
    return trimmedPassword.length > 20 ? AppString.passwordTooLong : null;
  }

  /// Validates that the confirm password matches the original password.
  ///
  /// Returns:
  /// - [AppString.confirmPasswordRequired] if confirm password is empty.
  /// - [AppString.passwordMismatch] if confirm password does not match original.
  /// - `null` if valid

  static String? validateConfirmPassword(
      String? confirmPassword, String originalPassword) {
    return _isEmpty(confirmPassword)
        ? AppString.confirmPasswordRequired
        : (confirmPassword!.trim() != originalPassword
            ? AppString.passwordMismatch
            : null);
  }

  /// Validates a user's name to contain only letters and spaces.
  ///
  /// Returns:
  /// - [AppString.emptyName] if the name is null or empty.
  /// - [AppString.nameTooShort] if the name is less than 2 characters.
  /// - [AppString.nameTooLong] if the name is more than 50 characters.
  /// - [AppString.nameInvalid] if the name contains invalid characters.
  /// - `null` if the name is valid.
  static String? validateName(String? name) {
    final trimmedName = name?.trim();
    if (_isEmpty(trimmedName)) return AppString.emptyName;
    if (trimmedName!.length < 2) return AppString.nameTooShort;
    if (trimmedName.length > 50) return AppString.nameTooLong;
    return _namePattern.hasMatch(trimmedName) ? null : AppString.nameInvalid;
  }

  /// Validates a Bangladeshi phone number (excluding the leading 0).
  ///
  /// Rules:
  /// - Must start with `1`
  /// - Must contain exactly 10 digits (e.g., 1712345678)
  ///
  /// Returns:
  /// - Error message if invalid or empty
  /// - `null` if valid
  static String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return AppString.emptyPhone;
    }
    final trimedPhone = phone.trim();

    final phoneRegExp = RegExp(r'^(1)[0-9]{9}$');
    if (!phoneRegExp.hasMatch(trimedPhone)) {
      return AppString.validatePhoneNumber;
    }
    return null;
  }
}
