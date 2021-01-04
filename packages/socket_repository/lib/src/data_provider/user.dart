import 'dart:async';

import '../models/user.dart';

export '../models/user.dart';

/// Provides all the CRUD [User] actions available.
abstract class UserDataProviderInterface {
  const UserDataProviderInterface();

  /// Creates an [User] with the given [name].
  Future<User> createUser(String name);

  /// Gets all the [User]s except the current logged user.
  Future<UserList> getContacts();

  /// Deletes an [User] with the given [id].
  Future<void> deleteUser(String id);

  /// Updates an [User] with the given [user.name].
  Future<User> updateUser(User user);
}
