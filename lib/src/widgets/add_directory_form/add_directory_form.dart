import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:organized_camera/src/localization/l10n.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';
import 'package:organized_camera/src/widgets/select_icon_dialog/select_icon_dialog.dart';
import 'package:organized_camera/src/widgets/select_icon_dialog/widgets/open_select_icon_dialog.dart';

class AddDirectoryForm extends StatefulWidget {
  const AddDirectoryForm({super.key});

  @override
  State<AddDirectoryForm> createState() => _AddDirectoryFormState();
}

class _AddDirectoryFormState extends State<AddDirectoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _directoryController = TextEditingController();
  int iconIndex = 0;

  @override
  Widget build(BuildContext context) {
    final t = Localization(context).translations;

    Future<bool> createDirectory() async {
      final newDirectory = SavedDirectory(
          directory: _directoryController.text,
          name: _nameController.text,
          iconId: availableIcons[iconIndex].icon?.codePoint ?? defaultIcon);
      final result = await SavedDirectoryData().create(newDirectory);
      return result >= 0;
    }

    void onSelectIconPressed() {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return Dialog(
              child: SelectIconDialog(
                index: iconIndex,
                setIndex: (newIndex) => setState(() {
                  iconIndex = newIndex;
                }),
              ),
            );
          });
    }

    void onSelectDirectory() {
      FilePicker.platform.getDirectoryPath().then((value) => setState(() {
            _directoryController.text = value ?? "";
          }));
    }

    void onCancel() {
      Navigator.of(context).pop();
    }

    void onSubmit() {
      if (_formKey.currentState?.validate() == true) {
        createDirectory().then((result) {
          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text(t?.addDirectoryFormSuccess ?? 'Directory added')),
            );
            Navigator.of(context).pop();
          }
        });
        return;
      }
    }

    return Padding(
      padding:
          MediaQuery.of(context).viewInsets, // Move up when keyboard is opened
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Wrap(
            runSpacing: 8.0,
            spacing: 16.0,
            children: [
              Center(
                child: Text(
                  t?.addDirectoryFormTitle ?? "Create a new directory profile",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return t?.addDirectoryFormProfileNameError ??
                              "The profile name is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text(t?.addDirectoryFormProfileNameHint ??
                              "Profile Name")),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  OpenSelectIconDialog(
                    onSelectIconPressed: onSelectIconPressed,
                    iconIndex: iconIndex,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: _directoryController,
                      decoration: InputDecoration(
                          label: Text(
                              t?.addDirectoryFormdirectoryHint ?? "Directory")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return t?.addDirectoryFormdirectoryError ??
                              "The directory is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  TextButton(
                    onPressed: onSelectDirectory,
                    child: Row(
                      children: [
                        const Icon(Icons.folder),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(t?.addDirectoryFormSelectDirectory ??
                              "Select directory"),
                        ),
                      ],
                    ),
                  ),
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
                      child: Text(t?.addDirectoryFormCancel ?? "Cancel")),
                  FilledButton.icon(
                      onPressed: onSubmit,
                      icon: const Icon(Icons.add),
                      label: Text(t?.addDirectoryFormCreate ?? "Create")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
