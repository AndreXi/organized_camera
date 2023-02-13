import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';
import 'package:organized_camera/src/widgets/saved_directory_list/saved_directory_tile.dart';

class SavedDirectoryList extends StatelessWidget {
  const SavedDirectoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<SavedDirectory>("saved_directories").listenable(),
        builder: (context, Box<SavedDirectory> box, _) {
          final directoriesMap = SavedDirectoryData().getAllMap();
          final List<SavedDirectoryTile> directoryCards = [];

          directoriesMap
              .forEach((key, value) => directoryCards.add(SavedDirectoryTile(
                    directory: value,
                    index: key,
                  )));

          return SizedBox(
            height: 300,
            child: GridView.count(
              crossAxisCount: 4,
              children: directoryCards,
            ),
          );
        });
  }
}
