import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:socket_repository/socket_repository.dart';

import 'observer.dart';
import 'screens/root.dart';
import 'state_managment/blocs/settings/bloc.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Observer();
  EquatableConfig.stringify = true;
  HydratedCubit.storage = await HydratedStorage.build();
  runApp(MyApp());
}

/// This contains all the data that the app has, the entry point of the app.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(),
      child: Builder(
        builder: (context) {
          return RepositoryProvider(
            create: (_) {
              final bloc = context.read<SettingsBloc>();
              final userID = '${SettingsKeys.userID}';
              final id = bloc.state.settings[userID];
              final log = Logger();
              log.i('The app initialized, id is $id');
              return SocketRepository(whoami: id);
            },
            child: MaterialApp(
              title: 'ChatApp',
              theme: theme,
              home: Home(),
              initialRoute: Home.route,
              onGenerateRoute: onGenerateRoute,
            ),
          );
        },
      ),
    );
  }
}
