part of './widgets.dart';

const _categories = ['Mensajes', 'Opciones'];

class TabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return _TabBar(
          onTap: (i) => context.read<TabCubit>().change(i),
          selectedIndex: context.select((TabCubit cubit) => cubit.state),
        );
      },
    );
  }
}

class _TabBar extends StatelessWidget {
  final Function(int) onTap;
  final int selectedIndex;

  _TabBar({
    @required this.onTap,
    @required this.selectedIndex,
  })  : assert(onTap != null),
        assert(selectedIndex != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.06
          : MediaQuery.of(context).size.height * 0.12,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Column(
                children: [
                  Text(
                    _categories[index],
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
              ),
            ),
          );
        },
      ),
    );
  }
}
