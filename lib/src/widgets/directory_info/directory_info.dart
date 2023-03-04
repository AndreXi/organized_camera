import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:organized_camera/src/localization/l10n.dart';
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
      if (mounted) {
        setState(() {
          _index = PreferencesData().getIndex();
          _directoryProfile = SavedDirectoryData().getAll()[_index!];
        });
      }
    });

    Hive.box<SavedDirectory>("saved_directories").listenable().addListener(() {
      if (mounted) {
        setState(() {
          if (_index != null) {
            _directoryProfile = SavedDirectoryData().getAll()[_index!];
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Localization(context).translations;

    final directoryProfile = _directoryProfile;
    final index = _index;

    if (index == null || directoryProfile == null) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                t?.directoryInfoEmpty ?? "You must select a profile first"),
          )));
    }

    directoryController.text = directoryProfile.directory;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    t?.directoryInfoProfileTitle ?? "Profile:",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  t?.directoryInfoDirectoryTitle ??
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
