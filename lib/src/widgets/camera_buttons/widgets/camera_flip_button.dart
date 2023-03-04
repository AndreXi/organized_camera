import 'package:flutter/material.dart';

class CameraFlipButton extends StatelessWidget {
  const CameraFlipButton({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Icon(Icons.flip_camera_android),
    );
  }
}
