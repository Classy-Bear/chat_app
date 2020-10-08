import 'package:flutter/material.dart';

class TabDW extends StatelessWidget {
  final int index;
  final List<String> categories;
  TabDW({this.index, this.categories});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabIndexCubit, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Column(
          children: [
            Text(
              categories[index],
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: index == state
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).disabledColor,
                  ),
            ),
            Container(
              color: index == state
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
              height: 5,
              width: 120,
            ),
          ],
        );
      },
    );
  }
}
