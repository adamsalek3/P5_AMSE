import 'package:flutter/material.dart';

class Exo5 extends StatefulWidget {
  const Exo5({super.key});

  @override
  State<Exo5> createState() => _Exo5State();
}

class _Exo5State extends State<Exo5> {
  int gridSize = 3; // Taille de la grille de base
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
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                int row = index ~/ gridSize;
                int col = index % gridSize;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding: const EdgeInsets.all(1),
                  child: createTileWidgetFrom(Tile(
                    imageURL: imageURL,
                    alignment: Alignment(
                      -1.0 + (2 * col / (gridSize - 1)),
                      -1.0 + (2 * row / (gridSize - 1)),
                    ),
                    widthFactor: 1 / gridSize,
                    heightFactor: 1 / gridSize,
                  )),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
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

class Tile {
  String imageURL;
  Alignment alignment;
  double widthFactor;
  double heightFactor;

  Tile(
      {required this.imageURL,
      required this.alignment,
      required this.widthFactor,
      required this.heightFactor});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Align(
          alignment: alignment,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: Image.network(imageURL),
        ),
      ),
    );
  }
}

Widget createTileWidgetFrom(Tile tile) {
  return InkWell(child: tile.croppedImageTile());
}
