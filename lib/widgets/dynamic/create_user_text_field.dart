part of '../widgets.dart';

/// The text field that is used when a user name is being typed.
class UserTextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<UserBloc>().state;
    return _UserTextField(
      error: state.status.isValidated || state.status.isPure
          ? null
          : state.validator.error,
      onChanged: (value) => context.read<UserBloc>().add(
            UserChanged(value: value),
          ),
    );
  }
}

/// The user interface of [UserTextFieldWidget].
class _UserTextField extends StatelessWidget {
  /// The input error validator of this.
  ///
  /// If this is `null`, then no error text will be shown.
  final UserTextFieldError error;

  /// Executed when this changes.
  final Function(String) onChanged;

  _UserTextField({
    @required this.error,
    @required this.onChanged,
  }) : assert(onChanged != null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Ingresa tu nombre...',
        labelText: 'Nombre',
        errorText: getCreateUserTextFieldErrorText(error),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
