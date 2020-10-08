import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

class Message extends Equatable {
  final User sender;
  final DateTime time;
  final String text;
  final bool unread;

  const Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });

  @override
  List<Object> get props => [sender, time, text, unread];
}
