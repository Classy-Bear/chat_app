part of './bloc.dart';

/// Represents the events of a textfield that validates and authenticates an
/// user.
///
/// Do not call this directly to add a new state, instead call events that
/// `extends` this class.
///
/// See:
/// - [AuthenticationBiometricSubmitted]
/// - [AuthenticationCodeSubmitted]
/// - [AuthenticationCodeTextFieldChanged]
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// This has to be added when a biometric authentication is submited.
class AuthenticationBiometricSubmitted extends AuthenticationEvent {
  const AuthenticationBiometricSubmitted();
}

/// This has to be added when a textfield with the code authentication is
/// submited.
class AuthenticationCodeSubmitted extends AuthenticationEvent {
  const AuthenticationCodeSubmitted();
}

/// This has to be added when the textfield is changed.
class AuthenticationCodeTextFieldChanged extends AuthenticationEvent {
  /// The textfield input.
  final String value;

  const AuthenticationCodeTextFieldChanged({
    @required this.value,
  }) : assert(value != null);

  @override
  List<Object> get props => [value];
}
