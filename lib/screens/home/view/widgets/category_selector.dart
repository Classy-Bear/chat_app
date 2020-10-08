import 'package:flutter/material.dart';

const categories = ['Mensajes', 'Opciones'];

class CategorySelector extends StatelessWidget {
  final Function(int) onTap;
  CategorySelector({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.06
          : MediaQuery.of(context).size.height * 0.12,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: TabDW(
                index: index,
                categories: categories,
              ),
            ),
          );
        },
      ),
    );
  }
}
