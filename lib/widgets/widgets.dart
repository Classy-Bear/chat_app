/// Contains general widgets and callbacks that updates the UI.
///
/// This also exports the `flutter/material.dart` import, you should import
/// library whenever you're using widgets or pages because it hides some
/// widgets that are not neccessary, instead this library has an upgraded or
/// stylish version of it.
///
/// To style and separate your sections use...
///
/// ```dart
/// CardContent()
/// ```
///
/// Use the customs widgets that this library has...
///
/// like a custom [AppBar] or...
///
/// ```dart
/// TopAppBar()
/// ```
///
/// just show a custom error [AlertDialog], no need to call the [showDialog()]
/// method from [Scaffold.of(context)].
///
/// ```dart
/// showErrorAlertDialog()
/// ```
///
/// You can do the same with [SnackBar]s.
///
/// ```dart
/// showSuccessSnackbar()
/// ```
///
/// This contains also callbacks that updates the UI of a page.
/// ```dart
/// onCodeAuthenticationStateSubmission() // Use this in [AuthenticationPage]
/// onCreateUserTextFieldSubmission() // Use this in [CreateUserPage]
/// ```
library widgets;

import 'package:flutter/material.dart';

import '../state_managment/blocs/user_text_field/bloc.dart';
import '../state_managment/blocs/authentication/bloc.dart';
import '../utils/utils.dart';

export 'package:flutter/material.dart' hide AlertDialog, AppBar;

part './callbacks.dart';
part './static/alert_dialog.dart';
part './static/card_content.dart';
part './static/app_bar.dart';
part './dynamic/authentication_code_text_field.dart';
part './static/authentication_code_button.dart';
part './dynamic/create_user_button.dart';
part './dynamic/create_user_text_field.dart';
