import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';

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
              builder: (context) => const AlertDialog(
                    title: Text("OS Error"),
                    content: Text(
                        "The selected path has write protection by system, check if the application has directory access permissions or select other directory to save it."),
                  ));
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
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
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
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 9,
            child: _controller.value.isInitialized
                ? Center(
                    child: CameraPreview(
                      _controller,
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: goBack, child: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 16.0,
                  ),
                  SizedBox(
                    height: double.infinity,
                    child: !_cameraBusy
                        ? ElevatedButton(
                            onPressed: _controller.value.isInitialized
                                ? takePhoto
                                : null,
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.photo_camera,
                              size: 32.0,
                            ))
                        : ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            )),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton(
                      onPressed:
                          _controller.value.isInitialized ? changeCamera : null,
                      child: const Icon(Icons.flip_camera_android)),
                ],
              ),
            ),
          ),
        ],
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

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
