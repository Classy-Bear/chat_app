import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';

class BiometricsAuthentication {
  final auth = LocalAuthentication();

  BiometricsAuthentication();

  Future<bool> isBiometricsAvailable() async {
    try {
      return await auth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      if (!await isBiometricsAvailable()) {
        throw Exception(
          'Su telófono celular no es compatible con el'
          'reconocimiento de huellas dactilares o rostro.',
        );
      }
      auth.stopAuthentication();
      return await auth.authenticateWithBiometrics(
        localizedReason: 'Escanee su huella para autenticarse',
        androidAuthStrings: AndroidAuthMessages(
          fingerprintHint: 'Toca el sensor de huellas.',
          fingerprintNotRecognized: 'Huella dactilar no reconocida.'
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
        throw Exception('Reinicie la aplicación.');
      }
    } catch (e) {
      throw Exception('Si ve este error, comuníquese con su proveedor.');
    }
  }
}
