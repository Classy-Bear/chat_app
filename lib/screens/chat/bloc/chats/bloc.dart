import 'dart:io' show InternetAddress, SocketException;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socket_repository/message_model.dart';
import 'package:socket_repository/socket_repository.dart';
import 'package:socket_repository/user_model.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template chat_app_chat_bloc_chats_chats_bloc}
/// The bloc that manages the logic of the incomming messages.
/// {@endtemplate}
class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final SocketRepository repository;

  ChatsBloc({
    @required this.repository,
  })  : assert(repository != null),
        super(ChatsState(<User, List<Message>>{}));

  @override
  Stream<ChatsState> mapEventToState(ChatsEvent event) async* {
    if (event is ChatsContactsFetched) {
      yield* _mapChatsContactsFetchedToState(event, state);
    }
    if (event is ChatsMessageCreatedArrived) {
      yield* _mapChatsMessageCreatedArrivedToState(event, state);
    }
    if (event is ChatsMessageCreated) {
      yield* _mapChatsMessageCreatedToState(event, state);
    }
    if (event is ChatsReaded) {
      yield* _mapChatsReadedToState(event, state);
    }
    if (event is ChatsUserAdded) {
      yield* _mapChatsUserCreatedToState(event, state);
    }
    if (event is ChatsUserDeleted) {
      yield* _mapChatsUserDeletedToState(event, state);
    }
  }

  /// The internal logic when [ChatsContactsFetched] is added to [state].
  ///
  /// When new users are fetched then this is called to update the users.
  Stream<ChatsState> _mapChatsContactsFetchedToState(
    ChatsContactsFetched event,
    ChatsState state,
  ) async* {
    final newState = state.chats;
    for (final user in event.contacts.users) {
      if (!newState.keys.contains(user)) newState[user] = <Message>[];
    }
    yield ChatsState(newState);
  }

  /// The internal logic when [ChatsContactsFetched] is added to [state].
  ///
  /// When new users are fetched then this is called to update the users.
  Stream<ChatsState> _mapChatsMessageCreatedArrivedToState(
    ChatsMessageCreatedArrived event,
    ChatsState state,
  ) async* {
    final newState = state.chats;
    newState[event.message.sender].add(event.message);
    yield ChatsState(newState);
  }

  /// The internal logic when [ChatsMessageCreated] is added to [state].
  ///
  /// Creates a message if there is internet connection and adds it to [state].
  Stream<ChatsState> _mapChatsMessageCreatedToState(
    ChatsMessageCreated event,
    ChatsState state,
  ) async* {
    final newState = state.chats;
    String errorMessage;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        repository.createMessage(event.message);
        newState[event.message.receiver].add(event.message);
      }
    } on SocketException {
      errorMessage = 'Comprueba tu conexión a Internet. '
          'Si el problema persiste contacte su proveedor.';
      // TODO Delete last message added.
    }
    yield ChatsState(newState, errorMessage: errorMessage);
  }

  /// The internal logic when [ChatsReaded] is added to [state].
  ///
  /// Changes the [Message.read] to `true` of a user.
  Stream<ChatsState> _mapChatsReadedToState(
    ChatsReaded event,
    ChatsState state,
  ) async* {
    final newState = state.chats;
    final messagesToReceiver = newState[event.receiver];
    String errorMessage;
    if (messagesToReceiver != null) {
      for (var i = messagesToReceiver.length - 1; i >= 0; i--) {
        final message = messagesToReceiver[i];
        if (message.read) {
          break;
        } else {
          final newMessage = message.copyWith(read: true);
          messagesToReceiver[i] = newMessage;
        }
      }
    } else {
      errorMessage = 'Algo inesperado ha pasado, reinicia la aplicación.';
    }
    yield ChatsState(newState, errorMessage: errorMessage);
  }

  /// The internal logic when [ChatsContactsFetched] is added to [state].
  ///
  /// When new users are fetched then this is called to update the users.
  Stream<ChatsState> _mapChatsUserCreatedToState(
    ChatsUserAdded event,
    ChatsState state,
  ) async* {
    final newState = state.chats;
    final user = newState.keys.singleWhere(
      (user) => user.id == event.user.id,
      orElse: () => null,
    );
    if (user == null) {
      newState[event.user] = <Message>[];
    } else {
      final chat = newState[user];
      newState[event.user] = chat;
      newState.remove(user);
    }
    yield ChatsState(newState);
  }

  /// The internal logic when [ChatsContactsFetched] is added to [state].
  ///
  /// When new users are fetched then this is called to update the users.
  Stream<ChatsState> _mapChatsUserDeletedToState(
    ChatsUserDeleted event,
    ChatsState state,
  ) async* {
    final newState = state.chats;
    newState.removeWhere((user, messages) => user.id == event.userID);
    yield ChatsState(newState);
  }
}
