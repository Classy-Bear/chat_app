part of 'bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationSubmitted extends AuthenticationEvent {
  final bool isBiometricsCorrect;

  const AuthenticationSubmitted({this.isBiometricsCorrect});

  @override
  List<Object> get props => [isBiometricsCorrect];
}

class AuthenticationCodeChanged extends AuthenticationEvent {
  const AuthenticationCodeChanged({@required this.code}) : assert(code != null);

  final String code;

  @override
  List<Object> get props => [code];
}
