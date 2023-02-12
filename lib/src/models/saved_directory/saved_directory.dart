import 'package:hive/hive.dart';

part 'saved_directory.g.dart';

// Remember to execute the build_runner
// flutter packages pub run build_runner build

// https://api.flutter.dev/flutter/material/Icons-class.html
const int defaultIcon = 0xe318; // Home

@HiveType(typeId: 0)
class SavedDirectory extends HiveObject {
  @HiveField(0)
  String directory;

  @HiveField(1)
  String name;

  @HiveField(2)
  int iconId;

  SavedDirectory({
    required this.directory,
    this.name = "No Name",
    this.iconId = defaultIcon,
  });
}
