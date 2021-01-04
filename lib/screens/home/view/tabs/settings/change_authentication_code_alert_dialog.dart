part of './settings.dart';

class ChangeAuthenticationCodeAlertDialogWidget extends StatefulWidget {
  @override
  _ChangeAuthenticationCodeAlertDialogWidgetState createState() =>
      _ChangeAuthenticationCodeAlertDialogWidgetState();
}

class _ChangeAuthenticationCodeAlertDialog extends StatefulWidget {
  final Widget onSuccess;
  final List<Widget> children;

  _ChangeAuthenticationCodeAlertDialog({
    @required this.children,
    @required this.onSuccess,
  })  : assert(onSuccess != null),
        assert(children != null);

  @override
  _ChangeAuthenticationCodeAlertDialogState createState() =>
      _ChangeAuthenticationCodeAlertDialogState();
}

class _ChangeAuthenticationCodeAlertDialogState
    extends State<_ChangeAuthenticationCodeAlertDialog> {
  List<Widget> children = [];

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
            'Código de verificación',
            style: Theme.of(context).textTheme.headline6,
            overflow: TextOverflow.fade,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusAll,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCELAR'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        widget.onSuccess,
      ],
    );
  }

  @override
  void initState() {
    for (var i = 0; i < widget.children.length; i++) {
      if (widget.children[i] is Container) continue;
      children.add(SizedBox(
        height: 24.0,
        width: 94.0,
      ));
      children.add(widget.children[i]);
    }
    super.initState();
  }
}

class _ChangeAuthenticationCodeAlertDialogWidgetState
    extends State<ChangeAuthenticationCodeAlertDialogWidget> {
  AuthenticationBloc _actualCodeBloc;
  AuthenticationBloc _newCodeBloc;
  AuthenticationBloc _repeatedNewCodeBloc;
  bool isOldCode;
  ChangeAuthenticationCodeButtonBloc _successBloc;

  @override
  Widget build(BuildContext context) {
    return _ChangeAuthenticationCodeAlertDialog(
      children: [
        (isOldCode != null)
            ? BlocProvider.value(
                value: _actualCodeBloc,
                child: ChangeAuthenticationCodeTextFieldWidget(
                  hintText: 'Escriba el código actual aquí...',
                ),
              )
            : Container(),
        BlocProvider.value(
          value: _newCodeBloc,
          child: ChangeAuthenticationCodeTextFieldWidget(
            hintText: 'Ingresa el nuevo código aquí...',
          ),
        ),
        BlocProvider.value(
          value: _repeatedNewCodeBloc,
          child: ChangeAuthenticationCodeTextFieldWidget(
            hintText: 'Repita el nuevo código aquí...',
          ),
        ),
        BlocProvider.value(
          value: _successBloc,
          child: Builder(builder: (context) {
            final state =
                context.watch<ChangeAuthenticationCodeButtonBloc>().state;
            if (state is ChangeAuthenticationCodeSubmittedFailure) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                  softWrap: true,
                ),
              );
            }
            return Container(
              width: MediaQuery.of(context).size.width,
            );
          }),
        ),
      ],
      onSuccess: BlocProvider.value(
          value: _successBloc,
          child: ChangeAuthenticationCodeTextButtonWidget()),
    );
  }

  @override
  void dispose() {
    _actualCodeBloc?.close();
    _newCodeBloc.close();
    _repeatedNewCodeBloc.close();
    _successBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    final twoFactorKey = SettingsKeys.toggleTwoFactorAuthentication;
    isOldCode = context.read<SettingsBloc>().state.settings[twoFactorKey];
    _actualCodeBloc = AuthenticationBloc(settings: null);
    _newCodeBloc = AuthenticationBloc(settings: null);
    _repeatedNewCodeBloc = AuthenticationBloc(settings: null);
    _successBloc = ChangeAuthenticationCodeButtonBloc(
      actualCodeBloc: isOldCode != null ? _actualCodeBloc : null,
      newCodeBloc: _newCodeBloc,
      repeatedNewCodeBloc: _repeatedNewCodeBloc,
      settingsBloc: context.read<SettingsBloc>(),
    );
    super.initState();
  }
}
