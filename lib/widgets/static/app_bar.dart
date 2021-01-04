part of '../widgets.dart';

/// Returns a custom [AppBar], use this instead of the default [AppBar].
class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Wether to show the back button.
  final bool hasBackButton;

  /// The [AppBar] title.
  final Widget title;

  const TopAppBar({
    this.hasBackButton,
    @required this.title,
  }) : assert(title != null);

  @override
  Size get preferredSize => Size.fromHeight(146.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasBackButton ?? false
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30.0,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      iconTheme: Theme.of(context).iconTheme,
      title: title,
      elevation: 0.0,
      toolbarHeight: 146.0,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
