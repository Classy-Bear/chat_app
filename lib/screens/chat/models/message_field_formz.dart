part of './models.dart';

/// Represents the error of the CreateUserTextField.
///
/// [MessageError.empty] when the value is `null` or the length is
/// 0.
enum MessageError {
  empty,
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
/// final validator = UserTextFieldValidator.dirty(value);
/// validator.isValid // Returns true.
/// ```
class MessageValidator extends FormzInput<String, MessageError> {
  /// The field value hasn't been updated.
  const MessageValidator.pure() : super.pure('');

  /// The field value has been updated.
  const MessageValidator.dirty([String value = '']) : super.dirty(value);

  @override
  MessageError validator(String value) {
    if (value.isEmpty) {
      return MessageError.empty;
    }
    return null;
  }
}
