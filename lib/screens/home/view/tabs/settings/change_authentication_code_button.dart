part of './settings.dart';

class ChangeAuthenticationCodeTextButtonWidget extends StatefulWidget {
  @override
  _ChangeAuthenticationCodeTextButtonWidgetState createState() =>
      _ChangeAuthenticationCodeTextButtonWidgetState();
}

class _ChangeAuthenticationCodeTextButtonWidgetState
    extends State<ChangeAuthenticationCodeTextButtonWidget> {
  bool isActualCodeBlocValid;
  bool isNewCodeBlocValid = false;
  bool isRepeatedNewCodeBlocValid = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final state = context.watch<ChangeAuthenticationCodeButtonBloc>().state;
        if (state is ChangeAuthenticationCodeSubmittedSuccess) {
          Navigator.pop(context);
        }
        return ElevatedButton(
          child: Text('OK'),
          onPressed: (isActualCodeBlocValid ?? true) &&
                  isNewCodeBlocValid &&
                  isRepeatedNewCodeBlocValid
              ? () {
                  context
                      .read<ChangeAuthenticationCodeButtonBloc>()
                      .add(ChangeAuthenticationCodeSubmitted());
                }
              : null,
        );
      },
    );
  }

  @override
  void initState() {
    context
        .read<ChangeAuthenticationCodeButtonBloc>()
        .actualCodeBloc
        ?.listen((data) {
      setState(() {
        isActualCodeBlocValid = data.status.isValid;
      });
    });
    context
        .read<ChangeAuthenticationCodeButtonBloc>()
        .newCodeBloc
        .listen((data) {
      setState(() {
        isNewCodeBlocValid = data.status.isValid;
      });
    });
    context
        .read<ChangeAuthenticationCodeButtonBloc>()
        .repeatedNewCodeBloc
        .listen((data) {
      setState(() {
        isRepeatedNewCodeBlocValid = data.status.isValid;
      });
    });
    super.initState();
  }
}
