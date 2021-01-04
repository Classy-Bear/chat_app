part of './bloc.dart';

/// Represents the events of a textfield that validates a [User.name].
///
/// Do not call this directly to add a new state, instead call events that
/// `extends` this class.
///
/// See:
/// - [UserChanged]
/// - [UserCreated]
/// - [UserUpdated]
abstract class UserEvent {
  const UserEvent();
}

/// This has to be added when the textfield input changes.
///
/// The [value] can't be `null`.
class UserChanged extends UserEvent {
  /// The current input value.
  final String value;

  const UserChanged({
    @required this.value,
  }) : assert(value != null);
}

/// This has to be added when the textfield input is submitted and the user is
/// meant to be created.
///
/// You can also update a user using [UserUpdated] instead of this.
class UserCreated extends UserEvent {
  const UserCreated();
}

/// This has to be added when the textfield input is submitted and the user is
/// meant to be updated.
///
/// You can also create a user using [UserCreated] instead of this.
class UserUpdated extends UserEvent {
  const UserUpdated();
}

/// This has to be added when the the user is meant to be deleted.
class UserDeleted extends UserEvent {
  const UserDeleted();
}
