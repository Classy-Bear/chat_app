part of './bloc.dart';

/// Represents a new value in a [key]/[value] pair.
///
/// __Don't__ modify the [SettingsState] directly like this:
///
/// ```dart
/// settings['${SettingsState.code}'] = '1234';
/// ```
///
/// Instead call this event. See [SettingsState] to get all the stored settings.
class SettingsEvent {
  /// The key of the stored [value].
  final SettingsKeys key;

  /// The value of the stored [key].
  final dynamic value;

  const SettingsEvent({@required this.key, @required this.value})
      : assert(key != null);
}
