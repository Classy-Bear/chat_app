part of './utils.dart';

extension DateTimeExtensions on DateTime {
  /// Returns this in the following format: '5:08 PM'.
  String get toJM {
    final formatter = DateFormat.jm();
    return formatter.format(this);
  }

  /// Returns this with the local time zone offset difference.
  ///
	/// ```dart
  /// final dateTimeInLosAngeles = ... // -8 of offset
  /// final dateTimeInMoscow = ... // +3 of offset
  /// // Asumming the local time (DateTime.now()) is in "Los Angeles".
  /// dateTimeInMoscow.getTimeZoneDifference // Will `subtract()` 11 hours.
  /// // Asumming the local time (DateTime.now()) is in "Moscow".
  /// dateTimeInLosAngeles.getTimeZoneDifference // Will `add()` 11 hours.
	/// ```
  DateTime get getTimeZoneDifference {
    final now = DateTime.now();
    final hours =
        now.timeZoneOffset.inHours.abs() + timeZoneOffset.inHours.abs();
    if (timeZoneOffset.inHours > now.timeZoneOffset.inHours) {
      return subtract(Duration(hours: hours));
    }
    if (timeZoneOffset.inHours < now.timeZoneOffset.inHours) {
      return add(Duration(hours: hours));
    }
    return this;
  }
}

extension StringExtensions on String {
  /// Converts a JavaScript [Date][1] to a Dart [DateTime].
  ///
  /// If this can't be converted, then `null` is returned.
  ///
  /// [1]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date
  DateTime get toDartDate {
    // The `this` keyword is necessary because it reference this `Object`.
    // ignore: unnecessary_this
    final dateToFormat = this.replaceAll(RegExp(r'[T]'), ' ');
    try {
      return DateTime.parse(dateToFormat);
    } on FormatException {
      return null;
    }
  }
}
