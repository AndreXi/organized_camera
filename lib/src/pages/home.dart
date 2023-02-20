import 'package:flutter/material.dart';
import 'package:organized_camera/src/pages/camera/camera_view.dart';
import 'package:organized_camera/src/widgets/add_directory_form/add_directory_form.dart';
import 'package:organized_camera/src/widgets/directory_info/directory_info.dart';
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
          return AddDirectoryForm();
        },
      );
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Organized Camera")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Select the directory:",
                            ),
                          ),
                          TextButton.icon(
                              onPressed: openAddDirectoryForm,
                              icon: Icon(Icons.add),
                              label: Text('Add new directory')),
                        ],
                      ),
                      Expanded(child: SavedDirectoryList()),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Directory info:",
                          ),
                        ),
                      ),
                      DirectoryInfo(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(CameraView.routeName),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.photo_camera,
                          size: 32.0,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
