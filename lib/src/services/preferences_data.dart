import 'package:hive/hive.dart';

class PreferencesData {
  final box = Hive.box<String>("preferences");

  int? getIndex() {
    final value = box.get("index");
    return int.tryParse(value ?? "");
  }

  void setIndex(int index) {
    box.put("index", index.toString());
  }
}
