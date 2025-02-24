import 'package:flutter/material.dart';

class Exo1 extends StatelessWidget {
  const Exo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image aléatoire")),
      body: Center(
        child: Image.network('https://picsum.photos/1920/1080'),
      ),
    );
  }
}
