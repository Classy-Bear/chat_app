import 'package:bloc/bloc.dart';
import 'package:chat_app/state_managment/states/text_field.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';

part 'event.dart';

/// The bloc that manages the logic of the incomming messages.
class MessageTextFieldBloc extends Bloc<MessageTextFieldEvent, TextFieldState> {
  MessageTextFieldBloc()
      : super(const TextFieldState(validator: MessageValidator.pure()));

  @override
  Stream<TextFieldState> mapEventToState(
    MessageTextFieldEvent event,
  ) async* {
    if (event is MessageTextFieldChanged) {
      yield _mapMessageTextFieldChangedToState(event, state);
    } else if (event is MessageTextFieldSubmitted) {
      yield _mapMessageTextFieldSubmittedToState(event, state);
    }
  }

  /// The internal logic when [MessageTextFieldChanged] is added to [state].
  ///
  /// This takes textfield value and validates it. This should be added each
  /// time the textfield changes, the [state] will hold the last input value.
  TextFieldState _mapMessageTextFieldChangedToState(
    MessageTextFieldChanged event,
    TextFieldState state,
  ) {
    final message = MessageValidator.dirty(event.message);
    return state.copyWith(
      validator: message,
      status: Formz.validate([message]),
    );
  }

  /// The internal logic when [MessageTextFieldSubmitted] is added to [state].
  ///
  /// This make cleans the textfield.
  TextFieldState _mapMessageTextFieldSubmittedToState(
    MessageTextFieldSubmitted event,
    TextFieldState state,
  ) {
    final message = MessageValidator.pure();
    return state.copyWith(
      validator: message,
      status: Formz.validate([message]),
    );
  }
}
