part of 'bloc.dart';

/// Represents the events of a textfield.
///
/// Do not call this directly to add a new state, instead call events that
/// `extends` this class.
abstract class MessageTextFieldEvent extends Equatable {
  const MessageTextFieldEvent();

  @override
  List<Object> get props => [];
}

/// This event has to be added when the textfield is changed.
class MessageTextFieldChanged extends MessageTextFieldEvent {
  const MessageTextFieldChanged({@required this.message});

  /// The current input value of the textfield.
  final String message;

  @override
  List<Object> get props => [message];
}

/// This event has to be added when the textfield is submitted.
class MessageTextFieldSubmitted extends MessageTextFieldEvent {
  const MessageTextFieldSubmitted();
}
