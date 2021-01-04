part of './settings.dart';

class DeleteUserNameAlertDialogWidget extends StatefulWidget {
  @override
  _DeleteUserNameAlertDialogWidgerState createState() =>
      _DeleteUserNameAlertDialogWidgerState();
}

class _DeleteUserNameAlertDialogWidget extends StatelessWidget {
  final Widget onSuccess;

  _DeleteUserNameAlertDialogWidget({
    @required this.onSuccess,
  }) : assert(onSuccess != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 24.0, right: 24.0),
      title: Row(
        children: [
          Icon(
            Icons.info,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 8),
          Text(
            'Eliminar mi cuenta',
            style: Theme.of(context).textTheme.headline6,
            overflow: TextOverflow.fade,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusAll,
      ),
      content: Text('Estás seguro de eliminar tu cuenta?'),
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

class _DeleteUserNameAlertDialogWidgerState
    extends State<DeleteUserNameAlertDialogWidget> {
  static UserBloc _newUserTextFieldBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _newUserTextFieldBloc,
      child: _DeleteUserNameAlertDialogWidget(
        onSuccess: _DeleteUserButtonWidget(),
      ),
    );
  }

  @override
  void dispose() {
    _newUserTextFieldBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _newUserTextFieldBloc = UserBloc(
      repository: context.read<SocketRepository>(),
      settings: context.read<SettingsBloc>(),
    );
    super.initState();
  }
}

/// Creates an user with [CreateUserTextFieldWidget] input.
class _DeleteUserButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<UserBloc>().state;
    if (state.status.isSubmissionSuccess) {
      Navigator.pop(context);
    }
    return _DeleteUserButon(
      onPressed: () => context.read<UserBloc>().add(UserDeleted()),
    );
  }
}

/// The user interface of  [_DeleteUserButtonWidget].
class _DeleteUserButon extends StatelessWidget {
  final void Function() onPressed;

  _DeleteUserButon({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: ElevatedButton(
        child: Text('ELIMINAR'),
        onPressed: onPressed,
      ),
    );
  }
}
