import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part './event.dart';
part './state.dart';

/// {@template chat_app_public_blocs_settings_bloc}
/// The bloc that manages the logic of the user preferences or data stored in
/// the device.
///
/// Add one of this events when using this:
/// - [SettingsEvent]
/// Expect one of this states when using this:
/// - [SettingsState]
///
/// __NOTE__: To see which preferences are available see [SettingsKeys].
/// {@endtemplate}
class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState(settings: <String, dynamic>{}));

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    yield* _mapAuthenticationRequestedToState(event, state);
  }

  /// The internal logic when [SettingsEvent] is added to [state].
  ///
  /// This stores a value in the database in a key/value way.
  Stream<SettingsState> _mapAuthenticationRequestedToState(
    SettingsEvent event,
    SettingsState state,
  ) async* {
    final inmutableStorage = state.settings;
    final mutableStorage = Map.of(inmutableStorage);
    mutableStorage['${event.key}'] = event.value;
    yield SettingsState(settings: mutableStorage);
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) => SettingsState(
        settings: json,
      );

  @override
  Map<String, dynamic> toJson(SettingsState state) {
    final json = <String, dynamic>{};
    final inmutableStorage = state.settings;
    inmutableStorage.keys.forEach(
      (settings) => json[settings] = inmutableStorage[settings],
    );
    return json;
  }
}

/// The keys that should be used when adding the [SettingsEvent] to state.
enum SettingsKeys {
  code,
  toggleTwoFactorAuthentication,
  userID,
  userName,
}
