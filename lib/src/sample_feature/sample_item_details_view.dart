import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatefulWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  State<SampleItemDetailsView> createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  String? selectedDirectory;

  @override
  Widget build(BuildContext context) {
    openTest() async {
      FilePicker.platform.getDirectoryPath().then((value) => setState(() {
            selectedDirectory = value;
          }));

      if (selectedDirectory == null) {
        // User canceled the pickera
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('More Information Here'),
            TextButton(onPressed: openTest, child: const Text("Test")),
            Text(selectedDirectory ?? "None")
          ],
        ),
      ),
    );
  }
}
