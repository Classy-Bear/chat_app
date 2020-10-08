import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../models/models.dart';

export 'package:formz/formz.dart';

part 'event.dart';
part 'state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationCodeChanged) {
      yield _mapCodeChangedToState(event, state);
    } else if (event is AuthenticationSubmitted) {
      yield* _mapAuthenticationRequestedToState(event, state);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationRequestedToState(
    AuthenticationSubmitted event,
    AuthenticationState state,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    final isAuthCorrect = event.isBiometricsCorrect ?? false;
    final code = state.code.value ?? '';
    // TODO [1] The auth code should not be aboslute.
    // TODO [2] Add the code to the database if is valid.
    if (isAuthCorrect || code == '0000') {
      yield state.copyWith(status: FormzStatus.submissionSuccess);
    } else {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }

  AuthenticationState _mapCodeChangedToState(
    AuthenticationCodeChanged event,
    AuthenticationState state,
  ) {
    final code = CodeTextField.dirty(event.code);
    return state.copyWith(
      code: code,
      status: Formz.validate([code]),
    );
  }
}
