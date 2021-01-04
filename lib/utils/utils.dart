/// This consists in a set of functionalities that the whole app needs.
///
/// This may be themes...
///
/// ```dart
/// Theme.of(context).textTheme.headline1 // Gets the app headline1
/// ```
///
/// or extensions...
/// ```dart
/// '2020-12-10T01:18:10.761Z'.toDartDate // '2020-12-10 01:18:10.761Z'
/// var soccerGame = new DateTime.parse('2020-12-10 01:18:10.761Z');
/// DateTime().toJM // '1:18AM'
/// ```
///
/// even routes as you know it...
/// ```dart
/// Navigator.pushNamed(HomePage.route);
/// ```
library utils;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:socket_repository/socket_repository.dart';

import '../main.dart';
import '../screens/authentication/view/page.dart';
import '../screens/chat/bloc/chats/bloc.dart';
import '../screens/chat/view/page.dart';
import '../screens/create_user/view/page.dart';
import '../screens/home/bloc/home_screen/bloc.dart';
import '../screens/home/bloc/tab_cubit.dart';
import '../screens/home/view/page.dart';
import '../screens/root.dart';
import '../state_managment/blocs/settings/bloc.dart';
import '../state_managment/blocs/user_text_field/bloc.dart';

export '../screens/authentication/view/page.dart';
export '../screens/chat/view/page.dart';
export '../screens/create_user/view/page.dart';
export '../screens/home/view/page.dart';

part './extensions.dart';
part './router.dart';
part './theme.dart';
