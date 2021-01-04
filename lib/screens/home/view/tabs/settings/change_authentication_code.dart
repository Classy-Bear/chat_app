part of './settings.dart';

class ChangeAuthenticationCodeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ChangeAuthenticationCode(
      alertDialog: Builder(builder: (_) {
        return BlocProvider.value(
          value: context.read<SettingsBloc>(),
          child: ChangeAuthenticationCodeAlertDialogWidget(),
        );
      }),
    );
  }
}

class _ChangeAuthenticationCode extends StatelessWidget {
  final Widget alertDialog;

  const _ChangeAuthenticationCode({
    @required this.alertDialog,
  }) : assert(alertDialog != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Cambiar código de autenticación'),
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (context) {
            return alertDialog;
          },
        );
      },
    );
  }
}
