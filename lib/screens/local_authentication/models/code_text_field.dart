import 'package:formz/formz.dart';

enum CodeTetxFieldValidationError { empty, noNumbers }

class CodeTextField extends FormzInput<String, CodeTetxFieldValidationError> {
  const CodeTextField.pure() : super.pure('');
  const CodeTextField.dirty([String value = '']) : super.dirty(value);

  @override
  CodeTetxFieldValidationError validator(String value) {
    if (value == null || value.isEmpty) {
      return CodeTetxFieldValidationError.empty;
    }
    if (!value.contains(RegExp(r'^[0-9]+$'))) {
      // Can only contain numbers.
      return CodeTetxFieldValidationError.noNumbers;
    }
    return null;
  }
}
