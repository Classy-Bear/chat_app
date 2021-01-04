part of './settings.dart';

class DeleteUserNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DeleteUserName(
      alertDialog: DeleteUserNameAlertDialogWidget(),
    );
  }
}

class _DeleteUserName extends StatelessWidget {
  final Widget alertDialog;

  const _DeleteUserName({
    @required this.alertDialog,
  }) : assert(alertDialog != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Borrar mi cuenta'),
      onTap: () {
        showDialog<void>(context: context, builder: (_) => alertDialog);
      },
    );
  }
}
