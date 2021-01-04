part of '../widgets.dart';

/// The user interface of [AuthenticationCodeButtonWidget].
class AuthenticationCodeButton extends StatelessWidget {
  /// Is executed when this is tapped.
  final Function() onPressed;

  /// The text of this.
  ///
  /// Consider using an action verb.
  final String text;

  AuthenticationCodeButton({
    @required this.onPressed,
    @required this.text,
  })  : assert(onPressed != null),
        assert(text != null);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
