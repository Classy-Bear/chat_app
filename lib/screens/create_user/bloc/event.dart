part of 'bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();
}

class CreateUserSubmitted extends CreateUserEvent {
  const CreateUserSubmitted({this.name}) : assert(name != null);

  final String name;

  @override
  List<Object> get props => [name];
}

class CreateUserChanged extends CreateUserEvent {
  const CreateUserChanged({this.name}) : assert(name != null);

  final String name;

  @override
  List<Object> get props => [name];
}
