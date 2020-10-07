part of 'bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = FormzStatus.pure,
    this.code = const CodeTextField.pure(),
  });

  final FormzStatus status;
  final CodeTextField code;

  AuthenticationState copyWith({
    FormzStatus status,
    CodeTextField code,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      code: code ?? this.code,
    );
  }

  @override
  List<Object> get props => [status, code];
}
