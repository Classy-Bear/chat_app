import 'package:flutter/material.dart';

abstract class SnackBarDW {
  static void error(BuildContext context) =>
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Row(children: [
          Icon(Icons.error),
          SizedBox(width: 16),
          Text('Error'),
        ]),
      ));
  static void success(BuildContext context) =>
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Row(children: [
          Icon(Icons.check),
          SizedBox(width: 16),
          Text('Éxito'),
        ]),
      ));
}
