import 'package:flutter/material.dart';
import 'package:organized_camera/src/widgets/select_icon_dialog/select_icon_dialog.dart';

class OpenSelectIconDialog extends StatelessWidget {
  final Function() onSelectIconPressed;
  final int iconIndex;

  const OpenSelectIconDialog(
      {super.key, required this.onSelectIconPressed, required this.iconIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.square(56.0),
      child: ElevatedButton(
        onPressed: onSelectIconPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
        child: Icon(
          availableIcons[iconIndex].icon,
          size: 24.0,
        ),
      ),
    );
  }
}
