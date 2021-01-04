part of './widgets.dart';

/// Submits the authentication in the current [context].
class AuthenticationCodeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final status = context.select(
      (AuthenticationBloc bloc) => bloc.state.status,
    );
    return AuthenticationCodeButton(
      onPressed: status.isValidated
          ? () => context.read<AuthenticationBloc>().add(
                AuthenticationCodeSubmitted(),
              )
          : null,
      text: 'VALIDAR',
    );
  }
}
