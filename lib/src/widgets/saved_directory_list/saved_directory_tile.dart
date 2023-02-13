import 'package:flutter/material.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';

class SavedDirectoryTile extends StatelessWidget {
  const SavedDirectoryTile(
      {super.key, required this.directory, required this.index});

  final dynamic index;
  final SavedDirectory directory;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Card(
      // color: Theme.of(context).colorScheme.surfaceVariant,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        // splashColor: Theme.of(context).colorScheme.primary,
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Spacer(),
              Icon(
                IconData(directory.iconId, fontFamily: 'MaterialIcons'),
                size: 42,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Spacer(),
              Text(
                directory.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
