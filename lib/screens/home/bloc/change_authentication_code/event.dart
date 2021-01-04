part of './bloc.dart';

/// This event has to be added when all textfields that manages the
/// authentication code are valid.
///
/// This submits all authentication codes and adds it to state.
class ChangeAuthenticationCodeSubmitted {
  const ChangeAuthenticationCodeSubmitted();
}
