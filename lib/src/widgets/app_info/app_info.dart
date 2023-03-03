import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri linkedinUrl = Uri.parse('https://www.linkedin.com/in/anx/');
final Uri githubUrl = Uri.parse('https://www.github.com/AndreXi');

class AppInfoButton extends StatelessWidget {
  const AppInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> linkedinLink() async {
      await launchUrl(linkedinUrl);
    }

    Future<void> githubLink() async {
      await launchUrl(githubUrl);
    }

    void onPressed() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      () {
        showAboutDialog(
          context: context,
          applicationName: packageInfo.appName,
          applicationVersion: packageInfo.version,
          children: [
            const Center(child: Text("Developed by @AndreXi")),
            const Center(child: Text("Andres Pereira")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: linkedinLink,
                  icon: SizedBox.square(
                      dimension: 24.0,
                      child: Image.asset("assets/icons/linkedin.png")),
                ),
                IconButton(
                  onPressed: githubLink,
                  icon: SizedBox.square(
                      dimension: 24.0,
                      child: Image.asset("assets/icons/github.png")),
                ),
              ],
            ),
          ],
        );
      }();
    }

    return TextButton(
      onPressed: onPressed,
      child: const Icon(Icons.info),
    );
  }
}
