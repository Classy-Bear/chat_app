part of './utils.dart';

/// Primary color
const _aquarine = Color(0xff74BDCB);

/// Background color
const _babyBlue = Color(0xffE7F2F8);

/// Secondary color
const _freesia = Color(0xFFEFE7BC);

/// Error color
const _salmon = Color(0xFFFFA384);

/// A [BorderRadius] of 30px in the top and right corner.
///
/// Use this only for the [CardContentComponent] widget.
BorderRadius get borderRadius {
  return BorderRadius.only(
    topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),
  );
}

/// A [BorderRadius] of 15px in all of his corners.
BorderRadius get borderRadiusAll {
  return BorderRadius.all(
    Radius.circular(15.0),
  );
}

/// This is the theme of the app.
///
/// You can access a theme property like this:
/// ```dart
/// Theme.of(context).colorScheme.primaryColor;
/// ```
/// But first call it like this in the [MaterialApp]:
/// ```dart
/// MaterialApp(
///   ...
///   theme: theme,
///   ...
/// )
/// ```
ThemeData get theme {
  return ThemeData(
    primaryColor: _colorScheme.primary,
    accentColor: _colorScheme.primary,
    colorScheme: _colorScheme,
    iconTheme: _iconTheme,
    textTheme: _textTheme,
    disabledColor: _colorScheme.onPrimary,
    buttonColor: _colorScheme.primary,
    inputDecorationTheme: _inputDecorationTheme,
    textSelectionTheme: _textSelectionTheme,
    scaffoldBackgroundColor: _colorScheme.background,
    elevatedButtonTheme: _elevatedButtonTheme,
  );
}

// TODO From this line and bellow document this code.

ColorScheme get _colorScheme {
  return ColorScheme.light(
    background: _babyBlue,
    error: _salmon,
    primary: _aquarine,
    // TODO Choose other color.
    onPrimary: Colors.grey[800],
    // TODO Choose other color.
    onSecondary: Colors.grey[50],
    secondary: _freesia,
  );
}

ElevatedButtonThemeData get _elevatedButtonTheme {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusAll,
      ),
    ),
  );
}

IconThemeData get _iconTheme {
  return IconThemeData(
    color: _colorScheme.onPrimary,
    size: 30.0,
  );
}

InputDecorationTheme get _inputDecorationTheme {
  return InputDecorationTheme(
    hintStyle: TextStyle(
      color: _colorScheme.onPrimary.withOpacity(0.60),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRadiusAll,
      borderSide: BorderSide(
        color: _colorScheme.onPrimary,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRadiusAll,
      borderSide: BorderSide(
        color: _colorScheme.primary,
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: borderRadiusAll,
      borderSide: BorderSide(
        width: 2.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: borderRadiusAll,
      borderSide: BorderSide(
        color: _colorScheme.error,
        width: 2.0,
      ),
    ),
    errorStyle: TextStyle(
      color: _colorScheme.error,
    ),
  );
}

TextSelectionThemeData get _textSelectionTheme {
  return TextSelectionThemeData(
    cursorColor: _colorScheme.primary,
    selectionColor: _colorScheme.primary,
    selectionHandleColor: _colorScheme.primary,
  );
}

TextTheme get _textTheme {
  return TextTheme(
    headline3: TextStyle(),
    headline4: TextStyle(),
    headline5: TextStyle(),
    headline6: TextStyle(),
    subtitle1: TextStyle(),
    subtitle2: TextStyle(),
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
    caption: TextStyle(),
    button: TextStyle(),
  );
}
