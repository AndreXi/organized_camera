import 'package:flutter/material.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';

class AddDirectoryForm extends StatefulWidget {
  const AddDirectoryForm({super.key});

  @override
  State<AddDirectoryForm> createState() => _AddDirectoryFormState();
}

class _AddDirectoryFormState extends State<AddDirectoryForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final directoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void createDirectory() async {
      final newDirectory = SavedDirectory(directory: '/sample');
      final result = await SavedDirectoryData().create(newDirectory);
      debugPrint(result.toString());
    }

    void onSelectIconPressed() {}

    void onCancel() {
      Navigator.of(context).pop();
    }

    void onSubmit() {
      if (_formKey.currentState?.validate() == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data')),
        );
        return;
      }
      debugPrint("Bad form");
    }

    Icon selectedIcon = Icon(
      Icons.home,
      color: Theme.of(context).primaryColor,
      size: 24.0,
    );

    return Padding(
      padding:
          MediaQuery.of(context).viewInsets, // Move up when keyboard is opened
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Wrap(
            runSpacing: 8.0,
            spacing: 16.0,
            children: [
              Center(
                child: Text(
                  "Create a new directory profile",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "The profile name is required";
                        }
                      },
                      autofocus: true,
                      decoration:
                          const InputDecoration(label: Text("Profile Name")),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  SizedBox.fromSize(
                    size: const Size.square(56.0),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        child: selectedIcon,
                        onTap: onSelectIconPressed,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: directoryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "The directory is required";
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  TextButton(
                      onPressed: createDirectory,
                      child: Row(
                        children: [
                          Icon(Icons.folder),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Select directory"),
                          ),
                        ],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                      ),
                      onPressed: onCancel,
                      child: const Text("Cancel")),
                  FilledButton.icon(
                      onPressed: onSubmit,
                      icon: const Icon(Icons.add),
                      label: const Text("Create")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
