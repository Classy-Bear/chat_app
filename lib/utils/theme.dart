import 'package:flutter/material.dart';

class ChatTheme {
  static get iconTheme {
    return IconThemeData(
      color: colorScheme.onPrimary,
      size: 30.0,
    );
  }

  static get textTheme {
    return TextTheme(
      headline3: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      headline4: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      headline5: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      headline6: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      subtitle1: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      subtitle2: TextStyle(
        color: colorScheme.onSecondary,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      bodyText1: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      bodyText2: TextStyle(
        color: colorScheme.onSecondary,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      caption: TextStyle(
        color: colorScheme.onSecondary,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      button: TextStyle(
        color: colorScheme.primary,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  static get colorScheme {
    return ColorScheme.light(
      secondary: freesia,
      primary: aquarine,
      background: babyBlue,
      onPrimary: Colors.grey[800],
      onSecondary: Colors.grey[50],
      error: salmon,
    );
  }

  static get inputDecorationTheme {
    return InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: Components.borderRadiusAll,
        borderSide: BorderSide(
          color: colorScheme.onPrimary,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: Components.borderRadiusAll,
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: Components.borderRadiusAll,
        borderSide: BorderSide(
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: Components.borderRadiusAll,
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 2.0,
        ),
      ),
      errorStyle: TextStyle(
        color: colorScheme.error,
      ),
    );
  }

  static const freesia = Color(0xFFEFE7BC);
  static const salmon = Color(0xFFFFA384);
  static const aquarine = Color(0xff74BDCB);
  static const babyBlue = Color(0xffE7F2F8);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: colorScheme.primary,
      colorScheme: colorScheme,
      iconTheme: iconTheme,
      textTheme: textTheme,
      disabledColor: colorScheme.onPrimary,
      cursorColor: colorScheme.primary,
      buttonColor: colorScheme.primary,
      inputDecorationTheme: inputDecorationTheme,
    );
  }
}

class Components {
  static get borderRadius {
    return BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    );
  }

  static get borderRadiusAll {
    return BorderRadius.all(
      Radius.circular(30.0),
    );
  }

  static get borderRadiusImage {
    return BorderRadius.all(
      Radius.circular(45.0),
    );
  }
}

