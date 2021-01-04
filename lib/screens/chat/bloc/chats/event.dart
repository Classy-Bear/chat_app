part of 'bloc.dart';

/// Represents the events of the chats.
///
/// A key with a empty list value is a contact.
/// ```dart
/// ChatsState state = ...;
/// String contactID = 'an-id-that-is-an-uuid-but-I-prefer-usign-the-word-id';
/// final isContact = state.chats[contactID].isEmpty;
/// if (isContact) {
///   // Is a contact.
/// } else {
///   // Is a chat, the user have started a conversation with [contactID].
/// }
/// ```
abstract class ChatsEvent {
  const ChatsEvent();
}

/// This must be added when the contacts were fetched.
class ChatsContactsFetched extends ChatsEvent {
  /// The new fetched contacts.
  final UserList contacts;

  const ChatsContactsFetched({
    @required this.contacts,
  }) : assert(contacts != null);
}

/// This must be added when a message will get sended.
class ChatsMessageCreated extends ChatsEvent {
  /// The message that just arrived.
  final Message message;

  const ChatsMessageCreated({
    @required this.message,
  }) : assert(message != null);
}

/// This must be added when a message that was created has arrived.
class ChatsMessageCreatedArrived extends ChatsEvent {
  /// The message that just arrived.
  final Message message;

  const ChatsMessageCreatedArrived({
    @required this.message,
  }) : assert(message != null);
}

/// This must be added when a message has been deleted.
class ChatsMessageDeleted extends ChatsEvent {
  /// The message id that was requested to be deleted.
  final String messageID;
  final String receiverID;

  const ChatsMessageDeleted({
    @required this.messageID,
    @required this.receiverID,
  })  : assert(messageID != null),
        assert(receiverID != null);
}

/// This must be added when the a new message has been readed.
class ChatsReaded extends ChatsEvent {
  /// The user that gets the message read.
  final User receiver;

  const ChatsReaded(this.receiver);
}

/// This must be added when a new user has been created.
class ChatsUserAdded extends ChatsEvent {
  /// The user that just get created.
  final User user;

  const ChatsUserAdded({
    @required this.user,
  }) : assert(user != null);
}

/// This must be added when a user has been deleted.
class ChatsUserDeleted extends ChatsEvent {
  /// The user id that was requested to be deleted.
  final String userID;

  const ChatsUserDeleted({
    @required this.userID,
  }) : assert(userID != null);
}
