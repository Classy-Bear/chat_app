part of 'bloc.dart';

class CreateUserState extends Equatable {
  const CreateUserState({
    this.status = FormzStatus.pure,
    this.createUser = const CreateUserFormz.pure(),
  });

  final FormzStatus status;
  final CreateUserFormz createUser;

  CreateUserState copyWith({
    FormzStatus status,
    createUser,
  }) {
    return CreateUserState(
      status: status ?? this.status,
      createUser: createUser ?? this.createUser,
    );
  }

  @override
  List<Object> get props => [status, createUser];
}
