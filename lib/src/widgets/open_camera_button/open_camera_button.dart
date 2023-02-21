import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:organized_camera/src/pages/camera/camera_view.dart';
import 'package:organized_camera/src/services/preferences_data.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenCameraButton extends StatelessWidget {
  const OpenCameraButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<String>("preferences").listenable(),
      builder: (context, _, __) {
        final isDirectorySelected = PreferencesData().getIndex() != null;

        void navigateToCamera() {
          Navigator.of(context).pushNamed(CameraView.routeName);
        }

        void onRequestPermission() async {
          // Close the dialog
          () {
            Navigator.of(context).pop();
          }();

          final status = await Permission.manageExternalStorage.request();

          if (status.isGranted) {
            return navigateToCamera();
          }

          if (status.isDenied || status.isPermanentlyDenied) {
            () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(status.isDenied
                      ? "Permissions denied by user"
                      : "Permission denied permanently, change this in settings")));
            }();
          }
        }

        void showRequestPermissionDialog() {
          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text(
                    "Permissions nedded!",
                  ),
                  content: const Text(
                      "We need to ask your permission to be able to read / write in all directories, so we can save your photos in your selected directory."),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: onRequestPermission, child: const Text("Ok"))
                  ],
                );
              });
        }

        void onOpenCameraPressed() async {
          final status = await Permission.manageExternalStorage.status;

          if (status.isGranted) {
            return navigateToCamera();
          }

          showRequestPermissionDialog();
        }

        return ElevatedButton(
            onPressed: isDirectorySelected ? onOpenCameraPressed : null,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: const Icon(
              Icons.photo_camera,
              size: 32.0,
            ));
      },
    );
  }
}
