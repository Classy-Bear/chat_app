part of './settings.dart';

class ChangeAuthenticationCodeTextFieldWidget extends StatelessWidget {
  final String hintText;

  const ChangeAuthenticationCodeTextFieldWidget({
    @required this.hintText,
  }) : assert(hintText != null);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return AuthenticationCodeTextFieldWidget(
          hintText: hintText,
        );
      },
    );
  }
}
