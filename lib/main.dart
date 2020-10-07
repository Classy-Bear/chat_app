import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'observer.dart';
import 'screens/local_authentication/local_authentication.dart';
import 'utils/utils.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  EquatableConfig.stringify = true;
  runApp(
    MyApp(),
  );
}

class ChatApp extends StatelessWidget {
  static const route = '/';
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: onSuccess,
        ),
        BlocListener<CreateUserBloc, CreateUserState>(
          listener: onSuccess,
        ),
      ],
      child: BlocBuilder<UserStatusCubit, bool>(builder: (context, state) {
        if (state == null) return Scaffold(body: Container());
        if (state) return AuthenticationPage();
        return CreateUserScreen();
      }),
    );
  }

  void onSuccess(BuildContext context, dynamic state) {
    if (state.status == FormzStatus.submissionSuccess) {
      //Navigator.of(context).pushAndRemoveUntil(
      // TODO [3] Push Home Screen if success.
      // RouteGenerator.getRoute(RouteGenerator.home),
      //(route) => false,
      //);
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ChatTheme.theme,
      home: ChatApp(),
      initialRoute: ChatApp.route,
      onGenerateRoute: ChatRouter.onGenerateRoute,
    );
  }
}
