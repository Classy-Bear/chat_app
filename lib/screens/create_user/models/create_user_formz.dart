import 'package:formz/formz.dart';

enum CreateUserFormzValidationError { empty, noLetters }

class CreateUserFormz
    extends FormzInput<String, CreateUserFormzValidationError> {
  const CreateUserFormz.pure() : super.pure('');
  const CreateUserFormz.dirty([String value = '']) : super.dirty(value);

  @override
  CreateUserFormzValidationError validator(String value) {
    if (value == null || value.isEmpty) {
      return CreateUserFormzValidationError.empty;
    }
    if (value.contains(RegExp(r'^[A-Za-z\s]+$'))) {
      // Can contain letters and spaces
      return CreateUserFormzValidationError.noLetters;
    }
    return null;
  }
}
