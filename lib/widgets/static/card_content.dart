part of '../widgets.dart';

/// This simulates a Material [Card] to use it as a background.
///
/// Use this to separate sections or contents of the app.
class CardContent extends StatelessWidget {
  final Widget child;
  final Color color;
  final BorderRadius cardBorderRadius;

  const CardContent({
    @required this.child,
    this.color,
    this.cardBorderRadius,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.background,
        borderRadius: borderRadius ?? cardBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? cardBorderRadius,
        child: child,
      ),
    );
  }
}
