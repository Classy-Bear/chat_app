import 'package:formz/formz.dart';

/// The input validation error while validating an auhtentication code.
///
/// [AuthenticationCodeError.empty] when the value is `null` or the length is 0.
/// [AuthenticationCodeError.noNumbers] when the value doesn't contains only
/// numbers.
enum AuthenticationCodeError {
  empty,
  noNumbers,
}

/// Validates an input that holds an auhtentication code.
///
/// Use [AuthenticationCodeValidator.dirty] when the value has been modified.
/// Use [AuthenticationCodeValidator.pure] when the value hasn't been modified.
///
/// Here's an example using this validator:
///
/// ```dart
/// String user = '1244'; // An input value.
/// final validator = AuthenticationCodeValidator.dirty(value);
/// validator.isValid // Returns true.
/// ```
class AuthenticationCodeValidator
    extends FormzInput<String, AuthenticationCodeError> {
  /// The field input has been updated.
  const AuthenticationCodeValidator.dirty([String value = ''])
      : super.dirty(value);

  /// The field input hasn't been updated.
  const AuthenticationCodeValidator.pure() : super.pure('');

  @override
  AuthenticationCodeError validator(String value) {
    if (value == null || value.isEmpty) {
      return AuthenticationCodeError.empty;
    }
    if (!value.contains(RegExp(r'^[0-9]+$'))) {
      return AuthenticationCodeError.noNumbers;
    }
    return null;
  }
}
