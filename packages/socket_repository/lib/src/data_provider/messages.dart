import '../models/message.dart';

export '../models/message.dart';

/// Provides all the CRUD [Message] actions available.
abstract class MessageDataProviderInterface {
  const MessageDataProviderInterface();

  /// Sends the [message] to the [message.receiver].
  void createMessage(Message message);
}
