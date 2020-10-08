part of 'bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

class CreateUserSubmitted extends CreateUserEvent {
  const CreateUserSubmitted();
}

class CreateUserChanged extends CreateUserEvent {
  const CreateUserChanged({@required this.name}) : assert(name != null);

  final String name;

  @override
  List<Object> get props => [name];
}
