import 'package:flutter/material.dart';

class SavedDirectory {
  final String directory;
  String name = "No name";
  int icon = Icons.home.codePoint;

  SavedDirectory(this.directory, this.name, this.icon);
}
