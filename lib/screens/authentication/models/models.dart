/// This library contains models that simulates the behaviour of some widgets of
// a page.
///
/// Functionalities at the momment:
///
/// 1. Use [authenticateMe] to authenticate the current user. It request a
/// biometric authentication.
///
/// For example:
///
/// ```dart
/// authenticateMe(context, AuthenticationBloc());
/// ```
library authentication_models;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import '../../../widgets/widgets.dart';
import '../../../state_managment/blocs/authentication/bloc.dart';

export 'package:formz/formz.dart';

part './biometrics_authentication.dart';
