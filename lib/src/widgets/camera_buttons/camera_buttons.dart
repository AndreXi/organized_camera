import 'package:flutter/material.dart';

class CameraButtons extends StatelessWidget {
  const CameraButtons({
    super.key,
    required this.backButton,
    required this.shotButton,
    required this.flipButton,
    this.axis = Axis.horizontal,
  });

  final Widget backButton;
  final Widget shotButton;
  final Widget flipButton;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: axis,
        spacing: 16.0,
        children: [
          backButton,
          shotButton,
          flipButton,
        ],
      ),
    );
  }
}

class CameraButtonsV extends CameraButtons {
  const CameraButtonsV(
      {super.key,
      required super.backButton,
      required super.shotButton,
      required super.flipButton});

  @override
  Widget build(BuildContext context) {
    return CameraButtons(
      backButton: backButton,
      shotButton: shotButton,
      flipButton: flipButton,
      axis: Axis.vertical,
    );
  }
}
