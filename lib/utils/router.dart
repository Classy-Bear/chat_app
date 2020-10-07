import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/create_user/create_user.dart';
import '../screens/home/home.dart';
import '../screens/local_authentication/local_authentication.dart';

class ChatRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case ChatApp.route:
        return MaterialPageRoute(
          builder: (_) => ChatApp(),
        );
      case AuthenticationPage.route:
        return MaterialPageRoute(
          builder: (_) => AuthenticationPage(),
        );
      case CreateUserPage.route:
        return MaterialPageRoute(
          builder: (_) => CreateUserPage(),
        );
      case HomePage.route:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case AuthenticationPage.route:
        //if (args is String) {
        //return MaterialPageRoute(
        //builder: (_) => SecondPage(
        //data: args,
        //),
        //);
        //}
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
