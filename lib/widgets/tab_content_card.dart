import 'package:flutter/material.dart';

import '../utils/theme.dart';

class TabContentCard extends StatelessWidget {
  final Widget child;
  final Color color;
  const TabContentCard({this.child, this.color});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.background,
          borderRadius: Components.borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: Components.borderRadius,
          child: child,
        ),
      ),
    );
  }
}
