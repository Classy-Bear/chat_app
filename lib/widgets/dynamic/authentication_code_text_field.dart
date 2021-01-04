part of '../widgets.dart';

/// The text field that is used when an authentication code is being typed.
class AuthenticationCodeTextFieldWidget extends StatelessWidget {
  /// The text displayed when the textfield is empty.
  final String hintText;

  const AuthenticationCodeTextFieldWidget({@required this.hintText})
      : assert(hintText != null);

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((AuthenticationBloc bloc) => bloc.state.status);
    final state = context.watch<AuthenticationBloc>().state;
    return _AuthenticationCodeTextField(
      error: status.isValidated || status.isPure ? null : state.validator.error,
      onChanged: (value) => context.read<AuthenticationBloc>().add(
            AuthenticationCodeTextFieldChanged(value: value),
          ),
      hintText: hintText,
    );
  }
}

/// This has to be used when the user is typing an authentication code.
class _AuthenticationCodeTextField extends StatelessWidget {
  /// Executed when this changes.
  final Function(String) onChanged;

  /// The input error validator of this.
  ///
  /// If this is `null`, then no error text will be shown.
  final AuthenticationCodeError error;

  /// The text displayed when the textfield is empty.
  final String hintText;

  const _AuthenticationCodeTextField({
    @required this.onChanged,
    @required this.error,
    @required this.hintText,
  })  : assert(onChanged != null),
        assert(hintText != null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: getCodeTextFieldError(error),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      obscureText: true,
    );
  }
}
