import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/preferences_data.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';
import 'package:organized_camera/src/widgets/saved_directory_list/widgets/saved_directory_tile.dart';

const int nColumns = 4;

class SavedDirectoryList extends StatefulWidget {
  const SavedDirectoryList({super.key});

  @override
  State<SavedDirectoryList> createState() => _SavedDirectoryListState();
}

class _SavedDirectoryListState extends State<SavedDirectoryList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<SavedDirectory>("saved_directories").listenable(),
        builder: (context, Box<SavedDirectory> box, _) {
          int? selectedIndex = PreferencesData().getIndex();
          final directoriesMap = SavedDirectoryData().getAllMap();

          final List<SavedDirectoryTile> directoryCards = [];
          int index = 0;
          directoriesMap.forEach((key, value) {
            directoryCards.add(SavedDirectoryTile(
              directory: value,
              index: index,
            ));
            index++;
          });

          final cardStates = List.filled(directoryCards.length, false);
          if (selectedIndex != null) {
            cardStates[selectedIndex] = true;
          }

          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GridView.count(
                padding: const EdgeInsets.all(8.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                crossAxisCount: nColumns,
                children: directoryCards.asMap().entries.map((card) {
                  return ToggleButtons(
                    fillColor: Theme.of(context).primaryColor,
                    selectedColor: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    isSelected: [cardStates[card.key]],
                    onPressed: (_) {
                      setState(() {
                        selectedIndex = card.key;
                      });
                      PreferencesData().setIndex(card.key);
                    },
                    children: [card.value],
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
