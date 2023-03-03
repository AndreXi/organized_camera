import 'package:flutter/material.dart';

class CameraLayout extends StatelessWidget {
  const CameraLayout(
      {super.key,
      required this.cameraPreview,
      required this.cameraControls,
      required this.cameraControlsV});

  final Widget cameraPreview;
  final Widget cameraControls;
  final Widget cameraControlsV;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return SizedBox(
          child: Flex(
            direction: isPortrait ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(child: Center(child: cameraPreview)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: isPortrait ? cameraControls : cameraControlsV,
              ),
            ],
          ),
        );
      },
    );
  }
}
