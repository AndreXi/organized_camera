import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:organized_camera/src/layout/camera_layout.dart';
import 'package:organized_camera/src/localization/l10n.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';
import 'package:organized_camera/src/widgets/camera_buttons/camera_buttons.dart';
import 'package:organized_camera/src/widgets/camera_buttons/widgets/camera_back_button.dart';
import 'package:organized_camera/src/widgets/camera_buttons/widgets/camera_flip_button.dart';
import 'package:organized_camera/src/widgets/camera_buttons/widgets/camera_shot_button.dart';

class _CameraContent extends StatefulWidget {
  const _CameraContent({required this.cameras});

  final List<CameraDescription> cameras;

  @override
  State<_CameraContent> createState() => _CameraContentState();
}

class _CameraContentState extends State<_CameraContent> {
  late CameraController _controller;

  final String? _savePath = SavedDirectoryData().getCurrentDirectory();

  int selectedCamera = 0;
  bool _cameraBusy = false;

  void goBack() {
    Navigator.of(context).pop();
  }

  void takePhoto() async {
    setState(() {
      _cameraBusy = true;
    });
    final image = await _controller.takePicture();
    await _controller.pausePreview();

    // Save to path
    if (_savePath != null) {
      // final targetPath = "${dir?.path}/${image.name}";

      try {
        await Directory(_savePath!).create(recursive: true);
      } on OSError catch (_) {
        () {
          showDialog(
              context: context,
              builder: (context) {
                final t = Localization(context).translations;

                return AlertDialog(
                  title: Text(t?.cameraOSError ?? "OS Error"),
                  content: Text(t?.cameraDirectoryWriteError ??
                      "The selected path has write protection by system, check if the application has directory access permissions or select other directory to save it."),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(t?.ok ?? "Ok"))
                  ],
                );
              });
        }();
      }
      final targetPath = "$_savePath/${image.name}";
      final file = await File(targetPath).create(recursive: true);
      await file.writeAsBytes(await image.readAsBytes(),
          mode: FileMode.writeOnly);
    }

    await _controller.resumePreview();
    setState(() {
      _cameraBusy = false;
    });
  }

  void changeCamera() {
    final cameras = widget.cameras.length;
    int newSelectedCamera = selectedCamera;

    if (selectedCamera + 1 >= cameras) {
      newSelectedCamera = 0;
    } else {
      newSelectedCamera++;
    }

    setState(() {
      selectedCamera = newSelectedCamera;
      _cameraBusy = false;
      _controller = CameraController(
          widget.cameras[selectedCamera], ResolutionPreset.max);
      handleControllerInit();
    });
  }

  void handleControllerInit() {
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            showDialog(
                context: context,
                builder: (context) {
                  final t = Localization(context).translations;
                  return AlertDialog(
                    title: Text(t?.cameraOSError ?? "OS Error"),
                    content: Text(t?.cameraPermissionsError ??
                        "Camera access denied, check app permissions."),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(t?.ok ?? "Ok"))
                    ],
                  );
                });
            break;
          default:
            showDialog(
                context: context,
                builder: (context) {
                  final t = Localization(context).translations;
                  return AlertDialog(
                    title: Text(t?.cameraOSError ?? "OS Error"),
                    content:
                        Text(t?.cameraUnknownError ?? "Unknown camera error"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(t?.ok ?? "Ok"))
                    ],
                  );
                });
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller =
        CameraController(widget.cameras[selectedCamera], ResolutionPreset.max);
    handleControllerInit();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: CameraLayout(
          cameraPreview: _controller.value.isInitialized
              ? Center(
                  child: CameraPreview(
                    _controller,
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
          cameraControls: CameraButtons(
            backButton: CameraBackButton(onPressed: goBack),
            shotButton: CameraShotButton(
              cameraBusy: _cameraBusy,
              onPressed: takePhoto,
            ),
            flipButton: CameraFlipButton(
              onPressed: _controller.value.isInitialized ? changeCamera : null,
            ),
          ),
          cameraControlsV: CameraButtonsV(
            backButton: CameraBackButton(onPressed: goBack),
            shotButton: CameraShotButton(
              cameraBusy: _cameraBusy,
              onPressed: takePhoto,
            ),
            flipButton: CameraFlipButton(
              onPressed: _controller.value.isInitialized ? changeCamera : null,
            ),
          ),
        ),
      ),
    );
  }
}

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  static const routeName = '/camera';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: availableCameras(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _CameraContent(cameras: snapshot.data ?? []);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
