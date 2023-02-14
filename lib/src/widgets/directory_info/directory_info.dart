import 'package:flutter/material.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';

class DirectoryInfo extends StatelessWidget {
  const DirectoryInfo({super.key, required this.directoryProfile});

  final SavedDirectory directoryProfile;

  @override
  Widget build(BuildContext context) {
    final directoryController =
        TextEditingController(text: directoryProfile.directory);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Card(
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
      ),
    );
  }
}
