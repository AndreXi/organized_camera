import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoButton extends StatelessWidget {
  const AppInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      () {
        showAboutDialog(
            context: context,
            applicationName: packageInfo.appName,
            applicationVersion: packageInfo.version,
            children: [Text("hi")]);
      }();
    }

    return TextButton(
      onPressed: onPressed,
      child: const Icon(Icons.info),
    );
  }
}
