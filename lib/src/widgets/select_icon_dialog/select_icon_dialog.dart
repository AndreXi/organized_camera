import 'package:flutter/material.dart';

const List<Icon> availableIcons = [
  Icon(Icons.home),
  Icon(Icons.group),
  Icon(Icons.family_restroom),
  Icon(Icons.work),
  Icon(Icons.landscape),
  Icon(Icons.star),
];

final List<int> availableIconsCodes =
    availableIcons.map((e) => e.icon!.codePoint).toList();

class SelectIconDialog extends StatelessWidget {
  const SelectIconDialog(
      {super.key, required this.index, required this.setIndex});

  final int index;
  final void Function(int index) setIndex;

  @override
  Widget build(BuildContext context) {
    final List<bool> selectedIcons = List.filled(availableIcons.length, false);
    selectedIcons[index] = true;

    return Container(
      clipBehavior: Clip.hardEdge,
      constraints: const BoxConstraints(maxHeight: 50.0, maxWidth: 295.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000.0)),
      child: ToggleButtons(
        isSelected: selectedIcons,
        children: availableIcons,
        onPressed: (int index) {
          setIndex(index);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
