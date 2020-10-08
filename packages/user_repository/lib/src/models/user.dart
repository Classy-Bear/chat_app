import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.uuid);

  final String uuid;

  @override
  List<Object> get props => [uuid];
}
