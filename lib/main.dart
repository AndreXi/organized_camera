import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:organized_camera/src/models/saved_directory/saved_directory.dart';

import 'src/app.dart';

void main() async {
  // Initialize Hive database
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(SavedDirectoryAdapter());

  // Open hive boxes
  await Hive.openBox<SavedDirectory>("saved_directories");
  await Hive.openBox<String>("preferences");

  runApp(const MyApp());
}
