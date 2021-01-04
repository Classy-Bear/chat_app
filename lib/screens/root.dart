import 'package:flutter/widgets.dart';

import '../state_managment/blocs/authentication/bloc.dart';
import '../state_managment/blocs/settings/bloc.dart';
import '../state_managment/blocs/user_text_field/bloc.dart';
import 'authentication/view/page.dart';
import 'create_user/view/page.dart';
import 'home/bloc/home_screen/bloc.dart';
import 'home/bloc/tab_cubit.dart';
import 'home/view/page.dart';

/// The widget that decides which page is seen when the app starts.
class Home extends StatefulWidget {
  /// A route that identifies this page.
  static const route = '/';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// Wether the two factor authentication is enabled.
  bool authenticationIsEnabled;

  @override
  Widget build(BuildContext context) {
    final userIDKey = '${SettingsKeys.userID}';
    final settings = context.watch<SettingsBloc>().state.settings;
    return Builder(
      builder: (context) {
        if (authenticationIsEnabled) {
          return BlocProvider(
            create: (_) => AuthenticationBloc(
              settings: context.read<SettingsBloc>(),
            ),
            child: AuthenticationPage(),
          );
        }
        if (settings[userIDKey] != null) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => HomePageBloc(
                  repository: context.read<SocketRepository>(),
                ),
              ),
              BlocProvider(
                create: (_) => TabCubit(),
              ),
            ],
            child: HomePage(),
          );
        }
        return BlocProvider(
          create: (_) => UserBloc(
            repository: context.read<SocketRepository>(),
            settings: context.read<SettingsBloc>(),
          ),
          child: CreateUserPage(),
        );
      },
    );
  }

  @override
  void initState() {
    final settings = context.read<SettingsBloc>().state.settings;
    final authKey = '${SettingsKeys.toggleTwoFactorAuthentication}';
    if ((settings[authKey] ?? false)) {
      authenticationIsEnabled = true;
    } else {
      authenticationIsEnabled = false;
    }
    super.initState();
  }
}
