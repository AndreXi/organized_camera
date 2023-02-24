import 'package:flutter/material.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/preferences_data.dart';
import 'package:organized_camera/src/widgets/edit_directory_form/edit_directory_form.dart';
import 'package:organized_camera/src/widgets/saved_directory_list/saved_directory_list.dart';

final ButtonStyle actionsBtnStyle = TextButton.styleFrom(
    minimumSize: Size.fromHeight(24.0), padding: EdgeInsets.all(0));

class SavedDirectoryTile extends StatelessWidget {
  const SavedDirectoryTile(
      {super.key, required this.directoryProfile, required this.index});

  final dynamic index;
  final SavedDirectory directoryProfile;

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

    return Container(
      width: double.infinity,
      height: double.infinity,
      // clipBehavior: Clip.hardEdge,
      // decoration: BoxDecoration(color: Colors.lightGreenAccent),
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / nColumns - 24.0,
          maxHeight: MediaQuery.of(context).size.width / nColumns - 24.0),
      child: GestureDetector(
        onLongPress: showTileActions,
        child: Column(
          children: [
            const Spacer(),
            Icon(
              IconData(directoryProfile.iconId, fontFamily: 'MaterialIcons'),
              size: 36,
              // color: Theme.of(context).colorScheme.primary,
            ),
            const Spacer(),
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
