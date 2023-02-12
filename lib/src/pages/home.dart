import 'package:flutter/material.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';
import 'package:organized_camera/src/widgets/add_directory_form/add_directory_form.dart';
import 'package:organized_camera/src/widgets/saved_directory_list/saved_directory_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    void openAddDirectoryForm() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AddDirectoryForm();
        },
      );
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Organized Camera")),
        body: Column(
          children: [
            SavedDirectoryList(),
            TextButton.icon(
                onPressed: openAddDirectoryForm,
                icon: Icon(Icons.add),
                label: Text('Add new save directory'))
          ],
        ));
  }
}
