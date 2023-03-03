import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/widgets/select_icon_dialog/select_icon_dialog.dart';
import 'package:organized_camera/src/widgets/select_icon_dialog/widgets/open_select_icon_dialog.dart';

class EditDirectoryForm extends StatefulWidget {
  const EditDirectoryForm({super.key, required this.directoryProfile});

  final SavedDirectory directoryProfile;

  @override
  State<EditDirectoryForm> createState() => _EditDirectoryFormState();
}

class _EditDirectoryFormState extends State<EditDirectoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _directoryController = TextEditingController();
  int iconIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.directoryProfile.name;
    _directoryController.text = widget.directoryProfile.directory;
    iconIndex = availableIconsCodes.indexOf(widget.directoryProfile.iconId);
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> editDirectory() async {
      widget.directoryProfile.directory = _directoryController.text;
      widget.directoryProfile.name = _nameController.text;
      widget.directoryProfile.iconId = availableIconsCodes[iconIndex];
      widget.directoryProfile.save();
      return true;
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
        editDirectory().then((result) {
          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Directory updated')),
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
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Wrap(
            runSpacing: 8.0,
            spacing: 16.0,
            children: [
              Center(
                child: Text(
                  "Edit a directory profile",
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
                          return "The profile name is required";
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(label: Text("Profile Name")),
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
                      decoration:
                          const InputDecoration(label: Text("Directory")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "The directory is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  TextButton(
                      onPressed: onSelectDirectory,
                      child: const Row(
                        children: [
                          Icon(Icons.folder),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
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
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
