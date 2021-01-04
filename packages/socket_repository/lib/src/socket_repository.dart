import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'data_provider/messages.dart';
import 'data_provider/user.dart';

/// The URL of the REST API server.
const _restURL = String.fromEnvironment('API_URL', defaultValue: '');

/// The URL of the websocket server.
const _socketURL = String.fromEnvironment('SOCKET_URL', defaultValue: '');

/// {@template chat_app_packages_socket_repository}
/// This repository handles the socket events and its callbacks.
/// {@endtemplate}
/// Pass the user id of the sender like this:
///
/// ```dart
/// final user = User(id: 'user-id', ...);
/// SocketRepository(user.id);
/// ```
///
/// if [id] is `null` then no user has been created yet.
class SocketRepository
    implements UserDataProviderInterface, MessageDataProviderInterface {
  /// Socket instance
  final _socket = io.io(_socketURL, <String, dynamic>{
    'transports': ['websocket'],
  });

  /// A http client instance.
  ///
  /// This will let this repository make HTTP requests.
  final _client = http.Client();

  /// This control all the incomming [Message]s.
  final _messageController = StreamController<Message>();

  /// This control all the incomming [User]s.
  final _userController = StreamController<User>();

  /// This control all the deleted [User]s.
  final _deletedUserController = StreamController<String>();

  /// This is the [User][id] of the person who is sending the [Message].
  ///
  /// This can't be `null` when listening for messages.
  String whoami;

  SocketRepository({this.whoami}) {
    _socket.on('connect', _onConnect);
    _socket.on('onCreatedUser', _onCreatedUser);
    _socket.on('onDeletedUser', _onDeletedUser);
    _socket.on('onUpdatedUser', _onUpdatedUser);
  }

  /// A stream of ids of deleted [Message]s.
  Stream<String> get deletedUsers => _deletedUserController.stream;

  /// A stream of [Message]s that is being send to this [User].
  Stream<Message> get messages => _messageController.stream;

  /// A stream of created [User]s that is being send to this [User].
  Stream<User> get users => _userController.stream;

  @override
  void createMessage(Message message) {
    _socket.emit('createdMessage', {
      'message': message.text,
      'sender': message.sender.id,
      'receiver': message.receiver.id,
      'sendDate': message.sendDate.toIso8601String(),
      'dateOffset': message.dateOffset.inHours,
    });
  }

  @override
  Future<User> createUser(String name) async {
    try {
      final response = await _client.post('$_restURL/users', body: {
        'user': name,
      });
      if (response.statusCode == HttpStatus.created) {
        final jsonMap = jsonDecode(response.body) as Map;
        final id = jsonMap['id'];
        final user = jsonMap['user'];
        _socket.emit('createdUser', {
          'id': id,
          'user': user,
        });
        whoami = id;
        return User(id: id, name: user);
      }
      if (response.statusCode == HttpStatus.internalServerError) {
        throw Exception(
          'El servidor no responde. '
          'Inténtalo de nuevo más tarde.',
        );
      }
      return null;
    } on SocketException {
      throw Exception('Revisa tu conexión a internet.');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      final response = await _client.delete('$_restURL/users/$id');
      if (response.statusCode == HttpStatus.ok) {
        final jsonMap = jsonDecode(response.body) as Map;
        final id = jsonMap['id'];
        _socket.emit('deletedUser', id);
      }
      if (response.statusCode == HttpStatus.internalServerError) {
        throw Exception(
          'El servidor no responde. '
          'Inténtalo de nuevo más tarde.',
        );
      }
      return null;
    } on SocketException {
      throw Exception('Revisa tu conexión a internet.');
    }
  }

  /// Closes all open connections.
  ///
  /// You must call this method after finishing with the repository. To cleanup
  /// resources.
  @required
  void dispose() {
    _userController.close();
    _messageController.close();
    _deletedUserController.close();
    _client.close();
    _socket.close();
  }

  @override
  Future<UserList> getContacts() async {
    _socket.on(whoami, _onReceivedMessage);
    try {
      final response = await _client.get('$_restURL/users');
      if (response.statusCode == HttpStatus.ok) {
        final contacts = jsonDecode(response.body) as List;
        final users = <User>[];
        for (final contact in contacts) {
          final id = contact['id'];
          final user = contact['user'];
          if (id == whoami) continue;
          users.add(User(id: id, name: user));
        }
        return UserList(users: users);
      }
      if (response.statusCode == HttpStatus.internalServerError) {
        throw Exception(
          'El servidor no responde. '
          'Inténtalo de nuevo más tarde.',
        );
      }
      return null;
    } on SocketException {
      throw Exception('Revisa tu conexión a internet.');
    }
  }

  @override
  Future<User> updateUser(User user) async {
    try {
      final response = await _client.put('$_restURL/users', body: {
        'id': user.id,
        'newUser': user.name,
      });
      if (response.statusCode == HttpStatus.ok) {
        final jsonMap = jsonDecode(response.body) as Map;
        final id = jsonMap['id'];
        final user = jsonMap['newUser'];
        _socket.emit('updatedUser', {
          'id': id,
          'user': user,
        });
        whoami = id;
        return User(id: id, name: user);
      }
      if (response.statusCode == HttpStatus.internalServerError) {
        throw Exception(
          'El servidor no responde. '
          'Inténtalo de nuevo más tarde.',
        );
      }
      return null;
    } on SocketException {
      throw Exception('Revisa tu conexión a internet.');
    }
  }

  /// This will be triggered when [whoami] connects.
  void _onConnect(_) {
    if (whoami != null) {
      _socket.emit('askForMessage', whoami);
    }
  }

  /// This will be triggered when a [User] has been created.
  void _onCreatedUser(userObject) {
    _userController.add(
      User(
        id: userObject['id'],
        name: userObject['user'],
      ),
    );
  }

  /// This will be triggered when a [User] has been deleted.
  void _onDeletedUser(id) {
    _deletedUserController.add(id);
  }

  /// This will be triggered when a [Message] has been received.
  void _onReceivedMessage(messages) {
    print(messages);
    if (messages == null) {
      _socket.emit('askForMessage', whoami);
      return;
    }
    for (final message in messages) {
      final sender = message['sender'];
      final receiver = message['receiver'];
      _messageController.add(
        Message(
          id: message['id'],
          text: message['text'],
          sender: User(
            id: sender['sender_id'],
            name: sender['sender_name'],
          ),
          receiver: User(
            id: receiver['receiver_id'],
            name: receiver['receiver_name'],
          ),
          sendDate: DateTime.parse(message['sendDate']),
          read: false,
          dateOffset: Duration(hours: message['dateOffset']),
        ),
      );
      _socket.emit('ack', message['id']);
    }
  }

  /// This will be triggered when a [User] has been updated.
  void _onUpdatedUser(userObject) {
    _userController.add(
      User(
        id: userObject['id'],
        name: userObject['user'],
      ),
    );
  }
}
