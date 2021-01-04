part of './bloc.dart';

/// Represents the state of a textfield that validates an authentication code.
///
/// Do not call this directly to add a new state, instead call events that
/// `extends` this class.
///
/// See:
/// - [ChangeAuthenticationCodeSubmittedSuccess]
/// - [ChangeAuthenticationCodeSubmittedFailure]
abstract class ChangeAuthenticationCodeState {
  const ChangeAuthenticationCodeState();
}

/// The state when attempting to change the authentication code succeeds.
class ChangeAuthenticationCodeSubmittedSuccess
    extends ChangeAuthenticationCodeState {
  const ChangeAuthenticationCodeSubmittedSuccess();
}

/// The state when attempting to change the authentication code fails.
class ChangeAuthenticationCodeSubmittedFailure
    extends ChangeAuthenticationCodeState {
  /// A message that informs what happend when it fails to change the code.
  ///
  /// You can use this in the user interface to inform the user what happend.
  final String message;
  const ChangeAuthenticationCodeSubmittedFailure({@required this.message})
      : assert(message != null);
}
