import 'package:hive/hive.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';
import 'package:organized_camera/src/services/preferences_data.dart';

class SavedDirectoryData {
  final box = Hive.box<SavedDirectory>("saved_directories");

  SavedDirectory? get(Object key) {
    final result = box.get(key);
    return result;
  }

  Map<dynamic, SavedDirectory> getAllMap() {
    final result = box.toMap();
    return result;
  }

  List<SavedDirectory> getAll() {
    final result = box.toMap().values.toList();
    return result;
  }

  Future<int> create(SavedDirectory element) async {
    final result = await box.add(element);
    return result;
  }

  String? getCurrentDirectory() {
    final currentIndex = PreferencesData().getIndex();
    final directory = getAllMap()[currentIndex]?.directory;
    return directory;
  }
}
