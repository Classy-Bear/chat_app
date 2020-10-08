import 'package:flutter/material.dart';

class AppBarSW extends StatelessWidget implements PreferredSizeWidget {
  final bool hasBackButton;
  final Widget title;
  const AppBarSW({this.hasBackButton, @required this.title});

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

  @override
  Size get preferredSize => Size.fromHeight(146.0);
}
