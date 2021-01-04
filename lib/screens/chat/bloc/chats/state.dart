part of 'bloc.dart';

/// The state of all the contacts and chats of the app.
///
/// If a value length is 0 then is a contact, if not is a chat,
/// because it holds a list of messages with that person.
class ChatsState {
  const ChatsState(this.chats, {this.errorMessage});

  final Map<User, List<Message>> chats;
  final String errorMessage;
}
