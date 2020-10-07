import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../models/create_user_formz.dart';

part 'event.dart';
part 'state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CreateUserBloc() : super(const CreateUserState());

  @override
  Stream<CreateUserState> mapEventToState(
    CreateUserEvent event,
  ) async* {
    if (event is CreateUserChanged) {
      yield _mapCreateUserChangedToState(event, state);
    } else if (event is CreateUserSubmitted) {
      yield* _mapCreateUserSubmittedToState(event, state);
    }
  }

  CreateUserState _mapCreateUserChangedToState(
    CreateUserChanged event,
    CreateUserState state,
  ) {
    final user = CreateUserFormz.dirty(event.name);
    return state.copyWith(
      createUser: user,
      status: Formz.validate([user]),
    );
  }

  Stream<CreateUserState> _mapCreateUserSubmittedToState(
    CreateUserSubmitted event,
    CreateUserState state,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    if (event.name.trim().isNotEmpty) {
      yield state.copyWith(status: FormzStatus.submissionSuccess);
      // TODO [5] Save the user that has been created in the database.
    } else {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}
