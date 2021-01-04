part of './widgets.dart';

/// {@macro chat_app_widgets_onSubmitStatus}
void onCreateUserTextFieldSubmission(
  BuildContext context,
  TextFieldState state,
) {
  assert(context != null);
  assert(state != null);
  _onSubmitStatus(
    context,
    state.status,
    () => showErrorAlertDialog(context, message: state.errorMessage),
  );
}

/// {@macro chat_app_widgets_onSubmitStatus}
///
/// __Note__: This doesn't handle the biometrics authentication. Only code
/// authentication.
void onCodeAuthenticationStateSubmission(
  BuildContext context,
  TextFieldState state,
) {
  assert(context != null);
  assert(state != null);
  _onSubmitStatus(
    context,
    state.status,
    () => showErrorSnackbar(context, errorText: 'Código inválido.'),
  );
}

/// {@template chat_app_widgets_onSubmitStatus}
/// Handles the [status] submissions.
///
/// When the [status] is [FormzStatus.submissionSuccess] this pushes a new
/// [HomePage], if is a [FormzStatus.submissionFailure] then [onError] is
/// executed.
/// {@endtemplate}
void _onSubmitStatus(
  BuildContext context,
  FormzStatus status,
  Function() onError,
) {
  if (status == FormzStatus.submissionSuccess) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      HomePage.route,
      (route) => false,
      arguments: HomePageArguments(
        repository: context.read<SocketRepository>(),
      ),
    );
  } else if (status == FormzStatus.submissionFailure) {
    onError();
  }
}

/// {@macro chat_app_widgets_get_error_text}
String getCreateUserTextFieldErrorText(UserTextFieldError error) {
  switch (error) {
    case UserTextFieldError.empty:
      return 'El campo no puede estar vacío.';
    case UserTextFieldError.noChars:
      return 'El campo solo puede contener letras.';
    default:
      return null;
  }
}

/// {@macro chat_app_widgets_get_error_text}
String getCodeTextFieldError(AuthenticationCodeError error) {
  switch (error) {
    case AuthenticationCodeError.empty:
      return 'El campo no puede estar vacío.';
    case AuthenticationCodeError.noNumbers:
      return 'El campo solo puede contener números.';
    default:
      return null;
  }
}

/// Shows an error [AlertDialog] within the current [context].
///
/// {@macro chat_app_widgets_context_ancestor_error}
Future<void> showErrorAlertDialog(
  BuildContext context, {
  String title,
  String message,
}) async {
  assert(context != null);
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ErrorAlertDialog(
          message: message,
        );
      });
}

/// Shows an error [SnackBar] within in the current [context].
///
/// {@macro chat_app_widgets_context_ancestor_error}
void showErrorSnackbar(BuildContext context, {String errorText}) {
  assert(context != null);
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Row(children: [
        Icon(Icons.error),
        SizedBox(width: 16),
        Text(errorText ?? 'Error'),
      ]),
    ),
  );
}

/// Shows a success [SnackBar] within in the current [context].
///
/// {@macro chat_app_widgets_context_ancestor_error}
void showSuccessSnackbar(BuildContext context, {String successText}) {
  assert(context != null);
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Row(children: [
        Icon(Icons.check),
        SizedBox(width: 16),
        Text(successText ?? 'Éxito'),
      ]),
    ),
  );
}

/// {@template chat_app_widgets_get_error_text}
/// Retuns a error message.
///
/// If [error] doesn't find any match then `null` is returned.
/// {@endtemplate}

/// {@template chat_app_widgets_context_ancestor_error}
/// If the context doesn't have an [Scaffold] ancestor, then this will throw
/// an error.
/// {@endtemplate}
