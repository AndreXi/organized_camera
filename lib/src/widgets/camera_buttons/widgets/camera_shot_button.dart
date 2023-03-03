import 'package:flutter/material.dart';

class CameraShotButton extends StatelessWidget {
  const CameraShotButton(
      {super.key, required this.cameraBusy, required this.onPressed});

  final bool cameraBusy;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.0,
      child: ElevatedButton(
        onPressed: !cameraBusy ? onPressed : null,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
        ),
        child: !cameraBusy
            ? const Icon(
                Icons.photo_camera,
                size: 32.0,
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
