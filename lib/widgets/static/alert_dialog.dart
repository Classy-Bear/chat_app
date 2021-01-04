part of '../widgets.dart';

/// Returns an [AlertDialog] of type error or designed as it.
class ErrorAlertDialog extends StatelessWidget {
  /// The explanation of the error.
  ///
  /// For example: "Something went wrong...".
  final String message;

  const ErrorAlertDialog({
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(width: 8),
          Text('Error'),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusAll,
      ),
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
