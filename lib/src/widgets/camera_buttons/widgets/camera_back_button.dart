import 'package:flutter/material.dart';

class CameraBackButton extends StatelessWidget {
  const CameraBackButton({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Icon(Icons.arrow_back),
    );
  }
}
