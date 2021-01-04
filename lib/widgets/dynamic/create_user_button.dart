part of '../widgets.dart';

/// This process the user input.
///
/// This will either create or update the user input depending on the [isNew]
/// parameter. If is a new user use the [isNew] parameter, if not, don't
/// use it, is `false` by default.
class UserButtonWidget extends StatelessWidget {
  /// If the user input is new, set this to `true`.
  final bool isNew;

  const UserButtonWidget({
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    final status = context.select<UserBloc, FormzStatus>(
      (value) => value.state.status,
    );
    return _UserButton(
      onPressed: status.isValid
          ? () => context.read<UserBloc>().add(
                isNew ? UserCreated() : UserUpdated(),
              )
          : null,
    );
  }
}

/// The user interface of [UserButtonWidget].
class _UserButton extends StatelessWidget {
  /// Will be triggered when this is tapped.
  final void Function() onPressed;

  const _UserButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: ElevatedButton(
        child: Text('CREAR'),
        onPressed: onPressed,
      ),
    );
  }
}
