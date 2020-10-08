import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  const User({@required this.uuid, @required this.name})
      : assert(uuid != null),
        assert(name != null);

  final String uuid;
  final String name;

  @override
  List<Object> get props => [uuid, name];
}
