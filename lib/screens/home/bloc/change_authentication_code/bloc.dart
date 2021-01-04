import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../state_managment/blocs/authentication/bloc.dart';
import '../../../../state_managment/blocs/settings/bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part './event.dart';
part './state.dart';

/// The bloc that manages the logic of changing the authentication code.
///
/// Add one of this events when using this:
/// - [ChangeAuthenticationCodeSubmitted]
/// Expect one of this states when using this:
/// - [ChangeAuthenticationCodeSubmittedSuccess]
/// - [ChangeAuthenticationCodeSubmittedFailure]
class ChangeAuthenticationCodeButtonBloc extends Bloc<
    ChangeAuthenticationCodeSubmitted, ChangeAuthenticationCodeState> {
  /// {@macro chat_app_public_blocs_settings_bloc}
  final SettingsBloc settingsBloc;

  /// The bloc that manages the current code that the user is using to
  /// authenticate itself.
  ///
  /// If this is null then the user haven't set a authentication code yet.
  final AuthenticationBloc actualCodeBloc;

  /// The bloc that manages the new code that the user will be using to
  /// authenticate itself.
  final AuthenticationBloc newCodeBloc;

  /// The bloc that manages the repeated new code that the user will be using to
  /// authenticate itself.
  ///
  /// The code value has to be equal to the [newCodeBloc] value.
  final AuthenticationBloc repeatedNewCodeBloc;

  ChangeAuthenticationCodeButtonBloc({
    @required this.actualCodeBloc,
    @required this.newCodeBloc,
    @required this.repeatedNewCodeBloc,
    @required this.settingsBloc,
  })  : assert(newCodeBloc != null),
        assert(repeatedNewCodeBloc != null),
        assert(settingsBloc != null),
        super(null);

  @override
  Future<void> close() {
    actualCodeBloc?.close();
    newCodeBloc.close();
    repeatedNewCodeBloc.close();
    return super.close();
  }

  @override
  Stream<ChangeAuthenticationCodeState> mapEventToState(
    ChangeAuthenticationCodeSubmitted event,
  ) async* {
    yield* _mapVerificationSubmittedToState(event, state);
  }

  /// The internal logic when [ChangeAuthenticationCodeSubmitted] is
  /// added to [state].
  ///
  /// Gets the new authentication code and changes it if all conditions apply.
  Stream<ChangeAuthenticationCodeState> _mapVerificationSubmittedToState(
    ChangeAuthenticationCodeSubmitted event,
    ChangeAuthenticationCodeState state,
  ) async* {
    String errorMessage;
    final storedCode = settingsBloc.state.settings[SettingsKeys.code];
    if (actualCodeBloc != null) {
      if (actualCodeBloc.state.validator.value != storedCode) {
        errorMessage = 'El código acutal no es correcto.';
      }
    }
    final newCode = newCodeBloc.state.validator.value;
    final repeatedNewCode = repeatedNewCodeBloc.state.validator.value;
    if (newCode != repeatedNewCode) {
      errorMessage = 'El código nuevo no coincide. Revise si los dos últimos '
          'campos son iguales';
    }
    if (errorMessage != null) {
      yield ChangeAuthenticationCodeSubmittedFailure(message: errorMessage);
    } else {
      settingsBloc.add(SettingsEvent(key: SettingsKeys.code, value: newCode));
      final authenticationkey = SettingsKeys.toggleTwoFactorAuthentication;
      if (settingsBloc.state.settings[authenticationkey] == null) {
        settingsBloc.add(SettingsEvent(key: authenticationkey, value: true));
      }
      yield ChangeAuthenticationCodeSubmittedSuccess();
    }
  }
}
