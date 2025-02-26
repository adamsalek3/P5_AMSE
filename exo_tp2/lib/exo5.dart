import 'package:flutter/material.dart';

class Exo5 extends StatefulWidget {
  const Exo5({super.key});

  @override
  State<Exo5> createState() => _Exo5State();
}

class _Exo5State extends State<Exo5> {
  int gridSize = 3; // Par défaut taille grille
  final String imageURL = 'https://picsum.photos/512';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double gridSizePx =
        (screenWidth < screenHeight ? screenWidth : screenHeight) * 0.9;

    return Scaffold(
      appBar: AppBar(title: const Text("Plateau de tuiles")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: gridSizePx,
            height: gridSizePx,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                int row = index ~/ gridSize;
                int col = index % gridSize;
                return CroppedTile(
                  imageURL: imageURL,
                  gridSize: gridSize,
                  row: row,
                  col: col,
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text("Taille du plateau : $gridSize x $gridSize",
                    style: const TextStyle(fontSize: 16)),
                Slider(
                  value: gridSize.toDouble(),
                  min: 2,
                  max: 6,
                  divisions: 4,
                  label: gridSize.toString(),
                  onChanged: (value) {
                    setState(() {
                      gridSize = value.toInt();
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

class CroppedTile extends StatelessWidget {
  final String imageURL;
  final int gridSize;
  final int row;
  final int col;

  const CroppedTile({
    super.key,
    required this.imageURL,
    required this.gridSize,
    required this.row,
    required this.col,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment(
          -1.0 + (2 * col / (gridSize - 1)), // Découpage horizontal
          -1.0 + (2 * row / (gridSize - 1)), // Découpage vertical
        ),
        widthFactor: 1 / gridSize,
        heightFactor: 1 / gridSize,
        child: Image.network(imageURL, fit: BoxFit.cover),
      ),
    );
  }
}
