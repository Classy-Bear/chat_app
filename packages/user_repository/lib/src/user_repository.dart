import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'models/models.dart';

class UserRepository {
  static const _url = 'http://localhost:5000/users';

  final httpClient = Client();

  UserRepository();

  Future<User> createUser(String user) async {
    if (user == null) throw ArgumentError('The user parameter can\'t be null');
    try {
      final response = await httpClient.post(_url, body: {'user': user});
      if (response.statusCode == HttpStatus.created) {
        final jsonDecoded = jsonDecode(response.body) as Map;
        return User(jsonDecoded['uuid']);
      } else {
        throw Exception('Failed to load JSON');
      }
    } catch (e) {
      rethrow;
    }
  }
}
