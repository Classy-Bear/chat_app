part of './settings.dart';

class ChangeUserNameAlertDialogWidget extends StatefulWidget {
  @override
  _ChangeUserNameAlertDialogWidgetState createState() =>
      _ChangeUserNameAlertDialogWidgetState();
}

class _ChangeUserNameAlertDialogWidget extends StatelessWidget {
  final Widget onSuccess;
  final Widget textField;

  _ChangeUserNameAlertDialogWidget({
    @required this.onSuccess,
    @required this.textField,
  })  : assert(onSuccess != null),
        assert(onSuccess != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 24.0, right: 24.0),
      titlePadding: EdgeInsets.all(24.0),
      title: Row(
        children: [
          Icon(
            Icons.info,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 8),
          Text(
            'Escribe tu nuevo nombre',
            style: Theme.of(context).textTheme.headline6,
            overflow: TextOverflow.fade,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusAll,
      ),
      content: textField,
      actions: <Widget>[
        FlatButton(
          child: Text('CANCELAR'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        onSuccess,
      ],
    );
  }
}

class _ChangeUserNameAlertDialogWidgetState
    extends State<ChangeUserNameAlertDialogWidget> {
  UserBloc newUserBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: newUserBloc,
      child: _ChangeUserNameAlertDialogWidget(
        onSuccess: _ChangeUserButtonWidget(),
        textField: _ChangeUserTextFieldWidget(),
      ),
    );
  }

  @override
  void dispose() {
    newUserBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    newUserBloc = UserBloc(
      repository: context.read<SocketRepository>(),
      settings: context.read<SettingsBloc>(),
    );
    super.initState();
  }
}

/// This has to be used when the user is typing an user name.
class _ChangeUserTextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<UserBloc>().state;
    if (state.status.isSubmissionSuccess) {
      Navigator.pop(context);
    }
    return _CreateUserTextField(
      error: state.status.isValidated || state.status.isPure
          ? null
          : state.validator.error,
      onChanged: (value) => context.read<UserBloc>().add(
            UserChanged(value: value),
          ),
    );
  }
}

/// The user interface of [DeleteUserTextFieldWidget].
class _CreateUserTextField extends StatelessWidget {
  final dynamic error;
  final Function(String) onChanged;

  _CreateUserTextField({
    @required this.error,
    @required this.onChanged,
  }) : assert(onChanged != null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Ingresa el nuevo nombre...',
        labelText: 'Nombre',
        errorText: getCreateUserTextFieldErrorText(error),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}

/// Creates an user with [_ChangeUserTextFieldWidget] input.
class _ChangeUserButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final status = context.select<UserBloc, FormzStatus>(
      (value) => value.state.status,
    );
    return _CreateUserButton(
      onPressed: status.isValidated
          ? () => context.read<UserBloc>().add(UserUpdated())
          : null,
    );
  }
}

/// The user interface of [_ChangeUserButtonWidget].
class _CreateUserButton extends StatelessWidget {
  final void Function() onPressed;

  _CreateUserButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: ElevatedButton(
        child: Text('CAMBIAR'),
        onPressed: onPressed,
      ),
    );
  }
}
