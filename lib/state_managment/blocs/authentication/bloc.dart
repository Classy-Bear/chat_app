import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import './models/authentication_code_text_field_validator.dart';
import '../../states/text_field.dart';
import '../settings/bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:formz/formz.dart';

export './models/authentication_code_text_field_validator.dart';
export '../../states/text_field.dart';

part './event.dart';

/// The bloc that manages the logic of the user authentication.
///
/// Add one of this events when using this:
/// - [TextFieldChanged]
/// Expect one of this states when using this:
/// - [TextFieldState]
class AuthenticationBloc extends Bloc<AuthenticationEvent, TextFieldState> {
  /// {@macro chat_app_state_managment_blocs_AuthenticationBloc}
  final SettingsBloc settings;

  /// Logs stuff to the console.
  final _log = Logger();

  AuthenticationBloc({@required this.settings})
      : super(const TextFieldState(
          validator: AuthenticationCodeValidator.pure(),
        ));

  @override
  Stream<TextFieldState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationCodeSubmitted) {
      yield* _mapAuthenticationCodeSubmittedToState(event, state);
    } else if (event is AuthenticationCodeTextFieldChanged) {
      yield _mapAuthenticationCodeTextFieldChangedToState(event, state);
    } else if (event is AuthenticationBiometricSubmitted) {
      yield* _mapAuthenticationBiometricSubmittedToState(event, state);
    }
  }

  /// The internal logic when [AuthenticationBiometricSubmitted] is added to
  /// [state].
  Stream<TextFieldState> _mapAuthenticationBiometricSubmittedToState(
    AuthenticationBiometricSubmitted event,
    TextFieldState state,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    final validator = AuthenticationCodeValidator.pure();
    yield state.copyWith(
      status: FormzStatus.submissionSuccess,
      validator: validator,
    );
  }

  /// The internal logic when [AuthenticationCodeSubmitted] is added to [state].
  ///
  /// This takes the textfield value and if it's valid it will look for it in
  /// the database to verify if the code matches with the one inputted.
  Stream<TextFieldState> _mapAuthenticationCodeSubmittedToState(
    AuthenticationCodeSubmitted event,
    TextFieldState state,
  ) async* {
    if (settings == null) {
      _log.e(
        'Error in "authentication/bloc.dart"',
        'The settings variable is null',
      );
      throw Exception('Reinicie la aplicación.');
    }
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      final codeKey = '${SettingsKeys.code}';
      final storedCode = settings.state.settings[codeKey];
      final inputCode = state.validator.value;
      final validator = AuthenticationCodeValidator.pure();
      if (inputCode == storedCode) {
        yield state.copyWith(
          status: FormzStatus.submissionSuccess,
          validator: validator,
        );
      } else {
        yield state.copyWith(
          errorMessage: 'Código incorrecto, inténtalo de nuevo.',
          status: FormzStatus.submissionFailure,
          validator: validator,
        );
      }
    }
  }

  /// The internal logic when [AuthenticationCodeTextFieldChanged] is added to
  /// [state].
  ///
  /// This takes the textfield value and validates it with
  /// [AuthenticationCodeValidator]. This should be added each time the
  /// textfield changes. The [state] will hold the last input value.
  TextFieldState _mapAuthenticationCodeTextFieldChangedToState(
    AuthenticationCodeTextFieldChanged event,
    TextFieldState state,
  ) {
    final validator = AuthenticationCodeValidator.dirty(event.value);
    return state.copyWith(
      validator: validator,
      status: Formz.validate([validator]),
    );
  }
}
