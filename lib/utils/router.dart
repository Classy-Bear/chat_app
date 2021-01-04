part of './utils.dart';

/// The [ChatPage] arguments when calling [Navigator.pushNamed].
class ChatPageArguments {
  final ChatsBloc chatsBloc;
  final User receiver;
  const ChatPageArguments({
    @required this.chatsBloc,
    @required this.receiver,
  })  : assert(chatsBloc != null),
        assert(receiver != null);
}

/// The [HomePage] arguments when calling [Navigator.pushNamed].
class HomePageArguments {
  final SocketRepository repository;
  const HomePageArguments({
    @required this.repository,
  }) : assert(repository != null);
}

/// The [ChatPage] arguments when calling [Navigator.pushNamed].
class CreateUserPageArguments {
  final SocketRepository repository;
  final SettingsBloc settingsBloc;
  const CreateUserPageArguments({
    @required this.repository,
    @required this.settingsBloc,
  })  : assert(repository != null),
        assert(settingsBloc != null);
}

/// Handles the [Route]s that were pushed using [Navigator.pushNamed].
///
/// Use this route generator in [MaterialApp.onGenerateRoute].
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Home.route:
      return MaterialPageRoute(
        builder: (_) => MyApp(),
      );
    case AuthenticationPage.route:
      return MaterialPageRoute(
        builder: (_) => AuthenticationPage(),
      );
    case CreateUserPage.route:
      final CreateUserPageArguments arguments = settings.arguments;
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => UserBloc(
                repository: arguments.repository,
                settings: arguments.settingsBloc,
              ),
            ),
          ],
          child: CreateUserPage(),
        ),
      );
    case HomePage.route:
      final HomePageArguments homePageArguments = settings.arguments;
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) => HomePageBloc(
              repository: homePageArguments.repository,
            ),
          ),
          BlocProvider(
            create: (_) => TabCubit(),
          ),
        ], child: HomePage()),
      );
    case ChatPage.route:
      final ChatPageArguments chatPageArguments = settings.arguments;
      return MaterialPageRoute(
        builder: (_) => ChatPage(
          chatsBloc: chatPageArguments.chatsBloc,
          receiver: chatPageArguments.receiver,
        ),
      );
    default:
      return null;
  }
}
