import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The attrubutes of a user that sends or receives a message.
class User extends Equatable {
  /// A sequence of chars taht identifies each user.
  ///
  /// It looks like this: 'dada94b8-5c19-4010-b00f-2c4a251286bb'.
  final String id;

  /// A more readble way to identify this, humans use it.
  ///
  /// It looks like this: 'John Doe'.
  final String name;

  const User({
    @required this.id,
    @required this.name,
  })  : assert(id != null),
        assert(name != null);

  /// Decodes this in a JSON format.
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  /// Encodes this in a JSON format.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  /// Creates a copy of this with the given fields replaced with the new values.
  User copyWith({
    String id,
    User name,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  @override
  List<Object> get props => [id, name];
}

/// A [List] of [User]s.
class UserList extends Equatable {
  /// A collection of [User]s
  final List<User> users;

  const UserList({@required this.users}) : assert(users != null);

  /// Decodes this in a JSON format.
  UserList.fromJson(Map<String, dynamic> json)
      : users = json['user'].map(
          (jsonUser) => User.fromJson(jsonUser),
        );

  /// Encodes this in a JSON format.
  Map<String, dynamic> toJson() => {
        'user': users.map((jsonUser) => jsonUser.toJson()).toList(),
      };

  /// Creates a copy of this with the given fields replaced with the new values.
  UserList copyWith({
    List<User> users,
  }) =>
      UserList(
        users: users ?? this.users,
      );

  @override
  List<Object> get props => [users];
}
