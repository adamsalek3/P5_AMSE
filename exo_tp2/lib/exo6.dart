import 'package:flutter/material.dart';
import 'dart:math' as math;

class Exo6 extends StatefulWidget {
  const Exo6({super.key});

  @override
  State<Exo6> createState() => _Exo6State();
}

class _Exo6State extends State<Exo6> {
  int gridSize = 4;
  late List<int> tiles;
  late int emptyIndex;

  @override
  void initState() {
    super.initState();
    _initializeTiles();
  }

  void _initializeTiles() {
    tiles = List.generate(gridSize * gridSize, (index) => index);
    emptyIndex = gridSize * gridSize - 1;
    setState(() {});
  }

  void swapTiles(int index) {
    if ((index % gridSize != 0 && index - 1 == emptyIndex) ||
        (index % gridSize != gridSize - 1 && index + 1 == emptyIndex) ||
        (index - gridSize == emptyIndex) ||
        (index + gridSize == emptyIndex)) {
      setState(() {
        tiles[emptyIndex] = tiles[index];
        tiles[index] = gridSize * gridSize - 1;
        emptyIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Taquin")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: gridSize * gridSize,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => swapTiles(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: tiles[index] == gridSize * gridSize - 1
                            ? Colors.white
                            : Colors.blue,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: tiles[index] == gridSize * gridSize - 1
                          ? const SizedBox.shrink()
                          : Text("${tiles[index] + 1}",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Taille du plateau : $gridSize x $gridSize",
                    style: const TextStyle(fontSize: 16)),
                Slider(
                  value: gridSize.toDouble(),
                  min: 2,
                  max: 6,
                  divisions: 3,
                  label: gridSize.toString(),
                  onChanged: (value) {
                    setState(() {
                      gridSize = value.toInt();
                      _initializeTiles();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
