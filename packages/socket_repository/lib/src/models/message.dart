import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'user.dart';

/// The attrubutes of a message that a user sends or receives.
class Message extends Equatable {
  /// The id of the message that is use to identificate the message.
  ///
  /// It looks like this: 'c77b1c0b-f177-486e-8d5a-c29a5f6630be'.
  final String id;

  /// The text of the message that a [User] sends or receives.
  ///
  /// It looks like this: 'Hello there!'.
  final String text;

  /// The [User] that sended this.
  final User sender;

  /// The [User] that is receiving this.
  final User receiver;

  /// The date the this was sended.
  final DateTime sendDate;

  /// The date the this was sended.
  final Duration dateOffset;

  /// If this has been read or not by the sender.
  final bool read;

  const Message({
    @required this.id,
    @required this.text,
    @required this.sender,
    @required this.receiver,
    @required this.sendDate,
    @required this.dateOffset,
    @required this.read,
  })  : assert(id != null),
        assert(text != null),
        assert(sender != null),
        assert(receiver != null),
        assert(sendDate != null),
        assert(dateOffset != null),
        assert(read != null);

  /// Decodes this in a JSON format.
  Message.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        sender = json['receiver'],
        receiver = json['receiver'],
        sendDate = json['sendDate'],
        dateOffset = json['dateOffset'],
        read = json['read'];

  @override
  List<Object> get props => [
        id,
        text,
        sender,
        receiver,
        sendDate,
        dateOffset,
        read,
      ];

  /// Creates a copy of this with the given fields replaced with the new values.
  Message copyWith({
    String id,
    String text,
    User sender,
    User receiver,
    DateTime sendDate,
    Duration dateOffset,
    bool read,
  }) =>
      Message(
        id: id ?? this.id,
        text: text ?? this.text,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        sendDate: sendDate ?? this.sendDate,
        dateOffset: dateOffset ?? this.dateOffset,
        read: read ?? this.read,
      );

  /// Encodes this in a JSON format.
  Map<String, dynamic> toJson() => {
        'text': text,
        'sender': sender,
        'receiver': receiver,
        'sendDate': sendDate,
        'dateOffset': dateOffset,
        'read': read,
      };
}

/// A [List] of [User]s.
class MessageList extends Equatable {
  /// A collection of [Message]s.
  final List<Message> messages;

  const MessageList({@required this.messages}) : assert(messages != null);

  /// Decodes this in a JSON format.
  MessageList.fromJson(Map<String, dynamic> json)
      : messages = json['message'].map(
          (jsonUser) => User.fromJson(jsonUser),
        );

  /// Encodes this in a JSON format.
  Map<String, dynamic> toJson() => {
        'message': messages.map((jsonUser) => jsonUser.toJson()).toList(),
      };

  @override
  List<Object> get props => [messages];

  /// Creates a copy of this with the given fields replaced with the new values.
  MessageList copyWith({
    List<Message> messages,
  }) =>
      MessageList(
        messages: messages ?? this.messages,
      );
}
