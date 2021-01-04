part of './models.dart';

/// Authenticates the user.
///
/// Calls a biometric authentication to authenticate the user.
void authenticateMe(BuildContext context, AuthenticationBloc bloc) {
  assert(context != null);
  assert(bloc != null);
  _BiometricsAuthentication().authenticate().then((isBiometricsCorrect) {
    if (isBiometricsCorrect) bloc.add(AuthenticationBiometricSubmitted());
  }).catchError(
    (e) {
      showErrorAlertDialog(
        context,
        message: e.message,
      );
    },
  );
}

/// Checks if the biometrics are available in the device.
Future<bool> isBiometricsAvailable() async =>
    await _BiometricsAuthentication().isBiometricsAvailable();

/// Handles the biometrics authentication of the device.
///
/// You can request a biometric authentication with the following:
///
/// ```dart
/// _BiometricsAuthentication().authenticate()
/// ```
///
/// The line above returns a `bool` indicating if authentication was correct or
/// not.
///
/// You can also see if is the biometrics are available with the following:
///
/// ```dart
/// _BiometricsAuthentication().isBiometricsAvailable()
/// ```
///
/// The line above returns a `bool` indicating if biometrics authentication are
/// available or not.
class _BiometricsAuthentication {
  /// An instance that authenticates the current user with biometrics.
  ///
  /// This comes from the `local_auth` package.
  final _localAuthentication = LocalAuthentication();

  /// Request a biometrics authentication and returns if the biometric was
  /// correct or not.
  ///
  /// If something goes wrong while authenticating the user, an [Exception] will
  /// be trown with a message that can be displayed in the UI.
  Future<bool> authenticate() async {
    try {
      if (!await isBiometricsAvailable()) {
        throw Exception(
          'Su telófono celular no es compatible con el'
          'reconocimiento de huellas digital o rostro.',
        );
      }
      await _localAuthentication.stopAuthentication();
      return await _localAuthentication.authenticateWithBiometrics(
        localizedReason: 'Escanee su huella para autenticarse',
        androidAuthStrings: AndroidAuthMessages(
          fingerprintHint: 'Toca el sensor de huellas.',
          fingerprintNotRecognized: 'Huella digital no reconocida.'
              'Intóntalo de nuevo.',
          fingerprintSuccess: 'Huella digital reconocida.',
          cancelButton: 'Cancelar',
          signInTitle: 'Autenticación de huella',
          fingerprintRequiredTitle: 'Se requiere la huella digital',
          goToSettingsButton: 'Ir a la configuración',
          goToSettingsDescription:
              'La huella digital no estó configurada en su dispositivo.'
              'Vaya a Configuración Seguridad para agregar su huella digital.',
        ),
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      final errorType = e.toString().split(',')[0].split('(')[1];
      if (errorType == 'LockedOut' || errorType == 'PermanentlyLockedOut') {
        throw Exception(
          'Ha hecho demasiados intentos, vuelva a intentarlo más tarde.',
        );
      } else {
        throw Exception('Reinicie la aplicación');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Checks if the biometrics are available in the device.
  Future<bool> isBiometricsAvailable() async {
    try {
      return await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }
}
