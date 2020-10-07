import 'package:formz/formz.dart';

enum CreteUserFormzValidationError { empty, noLetters }

class CreateUserFormz
    extends FormzInput<String, CreteUserFormzValidationError> {
  const CreateUserFormz.pure() : super.pure('');
  const CreateUserFormz.dirty([String value = '']) : super.dirty(value);

  @override
  CreteUserFormzValidationError validator(String value) {
    if (value == null || value.isEmpty) {
      return CreteUserFormzValidationError.empty;
    }
    if (value.contains(RegExp(r'^[A-Za-z\s]+$'))) {
      // Can contain letters and spaces
      return CreteUserFormzValidationError.noLetters;
    }
    return null;
  }
}
