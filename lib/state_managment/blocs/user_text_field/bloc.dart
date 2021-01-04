import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:socket_repository/socket_repository.dart';

import './models/user_text_field_validator.dart';
import '../../states/text_field.dart';
import '../settings/bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:formz/formz.dart';
export 'package:socket_repository/socket_repository.dart';

export './models/user_text_field_validator.dart';
export '../../states/text_field.dart';

part './event.dart';

/// The bloc that manages the logic of a textfield that creates an user.
///
/// Add one of this events when using this:
/// - [UserChanged]
/// - [UserCreated]
/// Expect one of this states when using this:
/// - [TextFieldState]
class UserBloc extends Bloc<UserEvent, TextFieldState> {
  /// {@macro chat_app_public_blocs_settings_bloc}
  final SettingsBloc settings;

  /// {@macro chat_app_packages_socket_repository}
  final SocketRepository repository;

  /// Logs stuff to the console.
  final _log = Logger();

  UserBloc({
    @required this.repository,
    @required this.settings,
  })  : assert(repository != null),
        assert(settings != null),
        super(const TextFieldState(validator: UserValidator.pure()));

  @override
  Stream<TextFieldState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is UserCreated) {
      yield* _mapUserCreatedToState(event, state);
    } else if (event is UserUpdated) {
      yield* _mapUserUpdatedToState(event, state);
    } else if (event is UserDeleted) {
      yield* _mapUserDeltedToState(event, state);
    }
  }

  /// The internal logic when [UserChanged] is added to [state].
  ///
  /// This takes the value and validates it. This should be added each time
  /// the textfield changes, the [state] will hold the last input value.
  TextFieldState _mapUserChangedToState(
    UserChanged event,
    TextFieldState state,
  ) {
    final value = UserValidator.dirty(event.value);
    return state.copyWith(
      validator: value,
      status: Formz.validate([value]),
    );
  }

  /// The internal logic when [UserCreated] is added to [state].
  ///
  /// Creates a user and stores it in the database.
  Stream<TextFieldState> _mapUserCreatedToState(
    UserCreated event,
    TextFieldState state,
  ) async* {
    if (!state.status.isValid) return;
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    final newUser = state.validator.value;
    try {
      final user = await repository.createUser(newUser);
      if (user == null) {
        _log.e(
          'Error in "user_text_field/bloc.dart"',
          'The user variable is null.\n'
              'Check the "createUser" function in the "socket_repository".',
        );
        throw Exception('Reinicie la aplicación.');
      }
      settings.add(SettingsEvent(
        key: SettingsKeys.userID,
        value: user.id,
      ));
      settings.add(SettingsEvent(
        key: SettingsKeys.userName,
        value: user.name,
      ));
      final validator = UserValidator.pure();
      yield state.copyWith(
        status: FormzStatus.submissionSuccess,
        validator: validator,
      );
    } catch (e) {
      yield state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      );
    }
  }

  /// The internal logic when [UserDeleted] is added to [state].
  ///
  /// Deletes the stored user.
  Stream<TextFieldState> _mapUserDeltedToState(
    UserDeleted event,
    TextFieldState state,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      final userID = '${SettingsKeys.userID}';
      await repository.deleteUser(settings.state.settings[userID]);
      settings.add(SettingsEvent(key: SettingsKeys.userID, value: null));
      settings.add(SettingsEvent(key: SettingsKeys.userName, value: null));
      final validator = UserValidator.pure();
      yield state.copyWith(
        status: FormzStatus.submissionSuccess,
        validator: validator,
      );
    } catch (e) {
      yield state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.message,
      );
    }
  }

  /// The internal logic when [UserUpdated] is added to [state].
  ///
  /// Updates the stored user.
  Stream<TextFieldState> _mapUserUpdatedToState(
    UserUpdated event,
    TextFieldState state,
  ) async* {
    if (!state.status.isValid) return;
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    final userName = state.validator.value;
    final userID = '${SettingsKeys.userID}';
    if (settings.state.settings[userID] == null) {
      _log.e(
        'Error in "user_text_field/bloc.dart"',
        'The userID variable is null.\n'
            'The user can\'t be updated before being created.',
      );
      throw Exception('Reinicie la aplicación.');
    } else {
      try {
        final userUpdated = await repository.updateUser(User(
          id: settings.state.settings[userID],
          name: userName,
        ));
        if (userUpdated == null) {
          _log.e(
            'Error in "user_text_field/bloc.dart"',
            'The userUpdated variable is null.\n'
                'Check the "updateUser" function in the "socket_repository".',
          );
          throw Exception('Reinicie la aplicación.');
        }
        settings.add(SettingsEvent(
          key: SettingsKeys.userName,
          value: userUpdated.name,
        ));
        settings.add(SettingsEvent(
          key: SettingsKeys.userID,
          value: userUpdated.id,
        ));
        final validator = UserValidator.pure();
        yield state.copyWith(
          status: FormzStatus.submissionSuccess,
          validator: validator,
        );
      } catch (e) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: 'Error',
        );
      }
    }
  }
}
