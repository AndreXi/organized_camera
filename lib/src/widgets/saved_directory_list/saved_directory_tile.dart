import 'package:flutter/material.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/widgets/saved_directory_list/saved_directory_list.dart';

class SavedDirectoryTile extends StatelessWidget {
  const SavedDirectoryTile(
      {super.key, required this.directory, required this.index});

  final dynamic index;
  final SavedDirectory directory;

  @override
  Widget build(BuildContext context) {
    return Container(
      // clipBehavior: Clip.hardEdge,
      // decoration: BoxDecoration(color: Colors.lightGreenAccent),
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / nColumns - 16.0,
          maxHeight: MediaQuery.of(context).size.width / nColumns - 16.0),
      child: Column(
        children: [
          const Spacer(),
          Icon(
            IconData(directory.iconId, fontFamily: 'MaterialIcons'),
            size: 42,
            // color: Theme.of(context).colorScheme.primary,
          ),
          const Spacer(),
          Text(
            directory.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
