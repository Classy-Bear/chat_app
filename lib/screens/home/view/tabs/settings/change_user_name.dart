part of './settings.dart';

class ChangeUserNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ChangeUserName(
      alertDialog: ChangeUserNameAlertDialogWidget(),
    );
  }
}

class _ChangeUserName extends StatelessWidget {
  final Widget alertDialog;

  const _ChangeUserName({
    @required this.alertDialog,
  }) : assert(alertDialog != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Cambiar mi nombre'),
      onTap: () {
        showDialog<void>(context: context, builder: (_) => alertDialog);
      },
    );
  }
}
