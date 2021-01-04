import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

/// Represents the input state of a textfield.
class TextFieldState extends Equatable {
  /// A error that informs what happen if something goes wrong.
  ///
  /// If this is `null` nothing has happened yet.
  final String errorMessage;

  /// The current status of the textfield.
  final FormzStatus status;

  /// The textfield validator.
  final dynamic validator;

  const TextFieldState({
    this.errorMessage,
    this.status = FormzStatus.pure,
    @required this.validator,
  }) : assert(validator != null);

  @override
  List<Object> get props => [
        errorMessage,
        status,
        validator,
      ];

  /// Creates a copy of this with the given fields replaced with the new values.
  TextFieldState copyWith({
    String errorMessage,
    FormzStatus status,
    dynamic validator,
  }) {
    return TextFieldState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      validator: validator ?? this.validator,
    );
  }
}
