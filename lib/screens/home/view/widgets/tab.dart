part of './widgets.dart';

class TabWidget extends StatelessWidget {
  final int index;
  final List<String> categories;

  TabWidget({
    @required this.index,
    @required this.categories,
  })  : assert(index != null),
        assert(categories != null);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<TabCubit>().state;
    return _Tab(
      name: categories[index],
      index: index,
      selectedIndex: selectedIndex,
    );
  }
}

class _Tab extends StatelessWidget {
  final String name;
  final int index;
  final int selectedIndex;

  const _Tab({
    @required this.name,
    @required this.index,
    @required this.selectedIndex,
  })  : assert(index != null),
        assert(selectedIndex != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: index == selectedIndex
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).disabledColor,
              ),
        ),
        Container(
          color: index == selectedIndex
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          height: 5,
          width: 120,
        ),
      ],
    );
  }
}
