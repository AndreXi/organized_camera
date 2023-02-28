import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/preferences_data.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';

class DirectoryInfo extends StatefulWidget {
  const DirectoryInfo({super.key});

  @override
  State<DirectoryInfo> createState() => _DirectoryInfoState();
}

class _DirectoryInfoState extends State<DirectoryInfo> {
  late int? _index;
  SavedDirectory? _directoryProfile;

  final directoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _index = PreferencesData().getIndex();
    if (_index != null) {
      _directoryProfile = SavedDirectoryData().getAll()[_index!];
    }

    Hive.box<String>("preferences").listenable().addListener(() {
      setState(() {
        _index = PreferencesData().getIndex();
        _directoryProfile = SavedDirectoryData().getAll()[_index!];
      });
    });

    Hive.box<SavedDirectory>("saved_directories").listenable().addListener(() {
      setState(() {
        if (_index != null) {
          _directoryProfile = SavedDirectoryData().getAll()[_index!];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final directoryProfile = _directoryProfile;
    final index = _index;

    if (index == null || directoryProfile == null) {
      return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Card(
              child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("You must select a profile first"),
          )));
    }

    directoryController.text = directoryProfile.directory;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    "Profile:",
                  ),
                  Expanded(
                    child: Text(
                      directoryProfile.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "The photos will be saved in:",
                ),
              ),
              TextField(
                readOnly: true,
                controller: directoryController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
