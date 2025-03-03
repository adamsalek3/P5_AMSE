import 'package:flutter/material.dart';
import 'exo1.dart';
import 'exo2.dart';
import 'exo4.dart';
import 'exo5.dart';
import 'exo6.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu des Exercices")),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Card(
            child: ListTile(
              title: const Text("Exercice 1 : Afficher une image"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Exo1()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Exercice 2 : Transformer une image"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Exo2()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(
                  "Exercice 4 : Affichage d'une tuile (un morceau d'image)"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Exo4()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title:
                  const Text("Exercice 5 :  Génération du plateau de tuiles"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Exo5()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Exercice 6 :  Animation d'une tuile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Exo6()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
