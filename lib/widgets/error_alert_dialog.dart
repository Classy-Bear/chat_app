import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ErrorAlertDialogSW extends StatelessWidget {
  final String title;
  final String message;
  const ErrorAlertDialogSW({this.title, this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(width: 16),
          Text(title ?? 'Error'),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: Components.borderRadiusAll),
      content: Text(message ?? 'Ha ocurrido un error.'),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
