import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout(
      {super.key,
      required this.directorySelector,
      required this.directoryInfo,
      required this.cameraButton});

  final Widget directorySelector;
  final Widget directoryInfo;
  final Widget cameraButton;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return Container(
          padding: const EdgeInsets.all(16.0),
          height: double.infinity,
          width: double.infinity,
          child: Flex(
            direction: isPortrait ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(child: directorySelector),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                  // flex: 40,
                  child: directoryInfo),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                // flex: 15,
                child: cameraButton,
              ),
            ],
          ),
        );
      },
    );
  }
}
