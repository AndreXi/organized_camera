import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Organized Camera")),
        body: GridView.count(
          crossAxisCount: 4,
          children: [
            GridTile(child: Text("Hola")),
            GridTile(child: Text("Hola")),
            GridTile(child: Text("Hola")),
            GridTile(child: Text("Hola")),
            GridTile(child: Text("Hola")),
            GridTile(child: Text("Hola")),
          ],
        ));
  }
}
