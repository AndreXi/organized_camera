import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class _CameraContent extends StatefulWidget {
  const _CameraContent({required this.cameras});

  final List<CameraDescription> cameras;

  @override
  State<_CameraContent> createState() => _CameraContentState();
}

class _CameraContentState extends State<_CameraContent> {
  late CameraController controller;
  int selectedCamera = 0;

  void goBack() {
    Navigator.of(context).pop();
  }

  void takePhoto() {
    controller.takePicture();
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
      controller = CameraController(
          widget.cameras[selectedCamera], ResolutionPreset.max);
      handleControllerInit();
    });
  }

  void handleControllerInit() {
    controller.initialize().then((_) {
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
    controller =
        CameraController(widget.cameras[selectedCamera], ResolutionPreset.max);
    handleControllerInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 9,
            child: CameraPreview(
              controller,
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: goBack,
                          child: const Icon(Icons.arrow_back)),
                      const SizedBox(
                        width: 16.0,
                      ),
                      SizedBox(
                        height: double.infinity,
                        child: ElevatedButton(
                            onPressed: takePhoto,
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(Icons.photo_camera)),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      ElevatedButton(
                          onPressed: changeCamera,
                          child: const Icon(Icons.flip_camera_android)),
                    ],
                  ),
                )
              ],
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
          if (snapshot.hasData) {
            return _CameraContent(cameras: snapshot.data ?? []);
          }
          return Container();
        });
  }
}
