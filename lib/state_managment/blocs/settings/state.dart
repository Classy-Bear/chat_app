part of './bloc.dart';

/// The state that holds all the user preferences or settings of the app.
///
/// Use the [settings] parameter to get a value like this:
///
/// ```dart
/// settings['${SettingsState.code}'] // Returns the authentication code.
/// ```
///
/// To add a value see [SettingsEvent].
class SettingsState {
  final Map<String, dynamic> settings;

  const SettingsState({@required this.settings}) : assert(settings != null);

  @override
  String toString() {
    return settings.toString();
  }
}
