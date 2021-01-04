import 'package:formz/formz.dart';

/// The input validation error.
///
/// [UserTextFieldError.empty] the input is `null` or the length is 0.
/// [UserTextFieldError.noChars] the input doesn't contains only chars.
enum UserTextFieldError {
  empty,
  noChars,
}

/// Validates an input that holds a username.
///
/// Use [UserValidator.dirty] when the value has been modified.
/// Use [UserValidator.pure] when the value hasn't been modified.
///
/// Here's an example using this validator:
///
/// ```dart
/// String user = 'George'; // A input value.
/// final validator = UserValidator.dirty(value);
/// validator.isValid // Returns true.
/// ```
class UserValidator extends FormzInput<String, UserTextFieldError> {
  /// The field input has been modified.
  const UserValidator.dirty(String value) : super.dirty(value);

  /// The field input hasn't been modified.
  const UserValidator.pure() : super.pure('');

  @override
  UserTextFieldError validator(String value) {
    if (value == null || value.isEmpty) {
      return UserTextFieldError.empty;
    }
    if (!value.contains(RegExp(r'^[a-zA-Z\s]*$'))) {
      return UserTextFieldError.noChars;
    }
    return null;
  }
}
