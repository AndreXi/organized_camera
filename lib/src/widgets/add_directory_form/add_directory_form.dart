import 'package:flutter/material.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';

class AddDirectoryForm extends StatelessWidget {
  const AddDirectoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    void createDirectory() async {
      final newDirectory = SavedDirectory(directory: '/sample');
      final result = await SavedDirectoryData().create(newDirectory);
      print(result);
    }

    return Container(
      height: double.infinity,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: createDirectory, child: Text("Create profile")),
        ],
      ),
    );
  }
}
