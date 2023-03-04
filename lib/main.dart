import 'dart:math';

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
  final directoriesBox =
      await Hive.openBox<SavedDirectory>("saved_directories");
  final prefBox = await Hive.openBox<String>("preferences");

  // Clear box
  await directoriesBox.clear();
  await prefBox.clear();

  // Add test data TODO: remove
  final testDirectories = [
    SavedDirectory(
        directory: "/storage/emulated/0/Work",
        name: 'Work ${Random().nextInt(0xFFF)}'),
    SavedDirectory(
        directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    SavedDirectory(
        directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    SavedDirectory(
        directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
    // SavedDirectory(
    //     directory: "/sample", name: 'Test ${Random().nextInt(0xFFF)}'),
  ];

  directoriesBox.addAll(testDirectories);

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(const MyApp());
}
