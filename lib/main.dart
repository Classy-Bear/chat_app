import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

import 'observer.dart';
import 'screens/home/home.dart';
import 'screens/local_authentication/local_authentication.dart';
import 'screens/create_user/create_user.dart';
import 'utils/utils.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  EquatableConfig.stringify = true;
  runApp(
    ChatApp(),
  );
}

class RootPage extends StatelessWidget {
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
      child: BlocBuilder<UserCubit, User>(builder: (context, state) {
        if (state == null) return CreateUserPage();
        return AuthenticationPage();
      }),
    );
  }

  void onSuccess(BuildContext context, dynamic state) {
    if (state.status == FormzStatus.submissionSuccess) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        HomePage.route,
        (route) => false,
      );
    }
  }
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ChatTheme.theme,
      home: RootPage(),
      initialRoute: RootPage.route,
      onGenerateRoute: ChatRouter.onGenerateRoute,
    );
  }
}
