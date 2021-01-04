/// This library contains dynamic widgets that behaves according to
/// [AuthenticationBloc].
///
/// None of this widgets that you will see in this library are static, they
/// contain themes, shapes, etc... but they are all dynamic.
///
/// An example will be [AuthenticationCodeButton] that behaves
/// differently according to the [AuthenticationState].
///
/// ```dart
/// AuthenticationCodeButton() // No parameters needed, all state is handled
/// for you.
/// ```
library authentication_dynamic_widgets;

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../../state_managment/blocs/authentication/bloc.dart';
import '../../../../widgets/widgets.dart';

part './authentication_code_button.dart';
