import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/preferences_data.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';

class DirectoryInfo extends StatelessWidget {
  const DirectoryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<String>("preferences").listenable(),
        builder: (context, box, _) {
          final index = PreferencesData().getIndex();

          if (index == null) {
            return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("You must select a profile first"),
                )));
          }

          final directoryProfile = SavedDirectoryData().getAll()[index];
          final directoryController =
              TextEditingController(text: directoryProfile.directory);

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
                        Text(
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
                    SizedBox(
                      height: 16.0,
                    ),
                    Align(
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
        });
  }
}
