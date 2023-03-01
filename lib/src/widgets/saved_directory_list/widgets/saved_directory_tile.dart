import 'package:flutter/material.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/preferences_data.dart';
import 'package:organized_camera/src/widgets/edit_directory_form/edit_directory_form.dart';

class SavedDirectoryTile extends StatelessWidget {
  const SavedDirectoryTile(
      {super.key,
      required this.directoryProfile,
      required this.index,
      required this.onPressed,
      required this.isSelected});

  final dynamic index;
  final SavedDirectory directoryProfile;
  final Function(int) onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    void onEditPressed() {
      Navigator.of(context).pop();
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return EditDirectoryForm(
            directoryProfile: directoryProfile,
          );
        },
      );
    }

    void onDeletePressed() {
      final selectedIndex = PreferencesData().getIndex() ?? 0;
      if (selectedIndex == index) {
        PreferencesData().resetIndex();
      } else {
        PreferencesData().moveIndex(selectedIndex > index ? -1 : 0);
      }

      directoryProfile.delete();
      Navigator.of(context).pop();
    }

    void showTileActions() {
      showDialog(
          context: context,
          builder: (ctx) => Dialog(
                clipBehavior: Clip.hardEdge,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      onTap: onEditPressed,
                      title: const Text("Edit"),
                    ),
                    ListTile(
                      onTap: onDeletePressed,
                      title: const Text("Delete"),
                    ),
                  ],
                ),
              ));
    }

    final selectedStyle = ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(8.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))));

    final normalStyle = ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))));

    return ElevatedButton(
      style: isSelected ? selectedStyle : normalStyle,
      onPressed: () => onPressed(index),
      onLongPress: showTileActions,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              IconData(directoryProfile.iconId, fontFamily: 'MaterialIcons'),
              size: 36,
            ),
            Text(
              directoryProfile.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              textScaleFactor: 0.9,
            )
          ],
        ),
      ),
    );
  }
}
