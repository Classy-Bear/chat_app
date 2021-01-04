part of './settings.dart';

class CodeActivationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final key = '${SettingsKeys.toggleTwoFactorAuthentication}';
    final value = context.watch<SettingsBloc>().state.settings[key];
    return _CodeActivation(
      value: value ?? false,
      onChanged: (newValue) {
        if (value == null) {
          isBiometricsAvailable().then((isAvailable) {
            if (isAvailable) {
              showDialog<void>(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    child: ChangeAuthenticationCodeAlertDialogWidget(),
                    value: context.read<SettingsBloc>(),
                  );
                },
              );
            } else {
              showErrorAlertDialog(
                context,
                message: 'Su telófono celular no es compatible con el'
                    'reconocimiento de huellas digital o rostro.',
              );
            }
          });
        } else {
          context.read<SettingsBloc>().add(
                SettingsEvent(
                  key: SettingsKeys.toggleTwoFactorAuthentication,
                  value: newValue,
                ),
              );
        }
      },
    );
  }
}

class _CodeActivation extends StatelessWidget {
  final bool value;
  final void Function(bool newValue) onChanged;

  _CodeActivation({
    @required this.value,
    @required this.onChanged,
  })  : assert(value != null),
        assert(onChanged != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Autenticación'),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
