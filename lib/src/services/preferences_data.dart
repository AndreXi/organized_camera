import 'package:hive/hive.dart';
import 'package:organized_camera/src/services/saved_directory_data.dart';

class PreferencesData {
  final box = Hive.box<String>("preferences");

  int? getIndex() {
    final value = box.get("index");
    return int.tryParse(value ?? "");
  }

  void setIndex(int index) {
    box.put("index", index.toString());
  }

  void moveIndex(int step) {
    final index = getIndex();
    final maxIndex = SavedDirectoryData().getAllMap().length;
    if (index == null) {
      return;
    }

    int newIndex = index + step;
    if (newIndex < 0) {
      newIndex = 0;
    }

    if (newIndex >= maxIndex) {
      newIndex = maxIndex - 1;
    }

    setIndex(newIndex);
  }

  void resetIndex() {
    box.delete("index");
  }
}
