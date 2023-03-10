import 'package:flutter/material.dart';
import 'package:organized_camera/src/localization/l10n.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/preferences_data.dart';
import 'package:organized_camera/src/widgets/edit_directory_form/edit_directory_form.dart';
import 'package:organized_camera/src/widgets/select_icon_dialog/select_icon_dialog.dart';

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
    final t = Localization(context).translations;

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
                      title: Text(t?.savedDirectoryTileActionsEdit ?? "Edit"),
                    ),
                    ListTile(
                      onTap: onDeletePressed,
                      title:
                          Text(t?.savedDirectoryTileActionsDelete ?? "Delete"),
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
            SizedBox.square(
              dimension: 32.0,
              child: FittedBox(
                fit: BoxFit.fill,
                child: availableIcons[
                    availableIconsCodes.indexOf(directoryProfile.iconId)],
              ),
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
