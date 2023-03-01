import 'package:flutter/material.dart';
import 'package:organized_camera/src/layout/home_layout.dart';
import 'package:organized_camera/src/widgets/add_directory_form/add_directory_form.dart';
import 'package:organized_camera/src/widgets/directory_info/directory_info.dart';
import 'package:organized_camera/src/widgets/open_camera_button/open_camera_button.dart';
import 'package:organized_camera/src/widgets/saved_directory_list/saved_directory_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    void openAddDirectoryForm() {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const AddDirectoryForm();
        },
      );
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Organized Camera")),
        body: HomeLayout(
          directorySelector: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Select the directory:",
                    ),
                  ),
                  TextButton.icon(
                      onPressed: openAddDirectoryForm,
                      icon: const Icon(Icons.add),
                      label: const Text('Add new directory')),
                ],
              ),
              const Expanded(child: SavedDirectoryList()),
            ],
          ),
          directoryInfo: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 14.0),
                  child: Text(
                    "Directory info:",
                  ),
                ),
              ),
              DirectoryInfo(),
            ],
          ),
          cameraButton: const OpenCameraButton(),
        ));
  }
}
