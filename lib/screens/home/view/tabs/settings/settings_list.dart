part of './settings.dart';

class SettingsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(settings: context.read<SettingsBloc>()),
      child: Builder(
        builder: (context) {
          final settingsState = context.watch<SettingsBloc>().state;
          final authKey = SettingsKeys.toggleTwoFactorAuthentication;
          return _SettingsListWidget(
            changeVerficationCode: settingsState.settings[authKey] != null
                ? ChangeAuthenticationCodeWidget()
                : Container(),
            codeActivation: CodeActivationWidget(),
            updateUserName: ChangeUserNameWidget(),
            deleteUserName: DeleteUserNameWidget(),
          );
        },
      ),
    );
  }
}

class _SettingsListWidget extends StatelessWidget {
  final Widget codeActivation;
  final Widget changeVerficationCode;
  final Widget updateUserName;
  final Widget deleteUserName;

  const _SettingsListWidget({
    @required this.codeActivation,
    @required this.changeVerficationCode,
    @required this.updateUserName,
    @required this.deleteUserName,
  })  : assert(codeActivation != null),
        assert(changeVerficationCode != null),
        assert(updateUserName != null),
        assert(deleteUserName != null);

  @override
  Widget build(BuildContext context) {
    return CardContent(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Seguridad',
                style: Theme.of(context).textTheme.headline6,
              ),
              codeActivation,
              changeVerficationCode,
              Divider(),
              Text(
                'Perfil',
                style: Theme.of(context).textTheme.headline6,
              ),
              updateUserName,
              deleteUserName,
            ],
          ),
        ),
      ),
    );
  }
}
