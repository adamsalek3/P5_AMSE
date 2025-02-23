import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Les données sont stockées dans assets/attractions.json

void main() {
  runApp(AttractionApp());
}

class AttractionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RCDB",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<String> likedAttractions = [];

  void toggleLike(String name) {
    setState(() {
      if (likedAttractions.contains(name)) {
        likedAttractions.remove(name);
      } else {
        likedAttractions.add(name);
      }
    });
  }

  List<Widget> get _pages => [
        HomePage(),
        AttractionsPage(toggleLike, likedAttractions),
        LikesPage(likedAttractions, toggleLike),
        AboutPage(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Attractions'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoris"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "A Propos"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network('https://i.imgur.com/TFfP7vW.jpeg',
              height: 200, fit: BoxFit.cover),
          SizedBox(height: 10),
          Text("Bienvenue sur Roller Coaster Data Base",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Venez parcourir vos attractions préférées !",
              style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}

void launchURL(String url) {
  // Fonction pour ouvrir le lien dans un navigateur
}

class AttractionsPage extends StatefulWidget {
  final Function toggleLike;
  final List<String> likedAttractions;
  AttractionsPage(this.toggleLike, this.likedAttractions);
  @override
  _AttractionsPageState createState() => _AttractionsPageState();
}

class _AttractionsPageState extends State<AttractionsPage> {
  List attractions = [];
  String selectedType = 'Tous';
  String selectedManufacturer = 'Tous';
  String selectedPark = 'Tous';

  @override
  void initState() {
    super.initState();
    loadAttractions();
  }

  Future<void> loadAttractions() async {
    String data = await rootBundle.loadString('assets/attractions.json');
    setState(() {
      attractions = json.decode(data);
    });
  }

  List<String> getAttractionTypes() {
    Set<String> types = {'Tous'};
    for (var attraction in attractions) {
      types.add(attraction['type']);
    }
    return types.toList();
  }

  List<String> getManufacturers() {
    Set<String> manufacturers = {'Tous'};
    for (var attraction in attractions) {
      manufacturers.add(attraction['manufacturer']);
    }
    return manufacturers.toList();
  }

  List<String> getParks() {
    Set<String> parks = {'Tous'};
    for (var attraction in attractions) {
      parks.add(attraction['park']);
    }
    return parks.toList();
  }

  @override
  Widget build(BuildContext context) {
    List filteredAttractions = attractions.where((attraction) {
      bool matchesType =
          selectedType == 'Tous' || attraction['type'] == selectedType;
      bool matchesManufacturer = selectedManufacturer == 'Tous' ||
          attraction['manufacturer'] == selectedManufacturer;
      bool matchesPark =
          selectedPark == 'Tous' || attraction['park'] == selectedPark;
      return matchesType && matchesManufacturer && matchesPark;
    }).toList();

    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            SizedBox(height: 5),
            Flexible(
              child: DropdownButtonFormField<String>(
                value: selectedType,
                decoration: InputDecoration(
                  labelText: "Type",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                ),
                items: getAttractionTypes()
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedType = value!;
                  });
                },
              ),
            ),
            Flexible(
              child: DropdownButtonFormField<String>(
                value: selectedManufacturer,
                decoration: InputDecoration(
                  labelText: "Constructeur",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                ),
                items: getManufacturers()
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedManufacturer = value!;
                  });
                },
              ),
            ),
            Flexible(
              child: DropdownButtonFormField<String>(
                value: selectedPark,
                decoration: InputDecoration(
                  labelText: "Parc",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                ),
                items: getParks()
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPark = value!;
                  });
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredAttractions.length,
            itemBuilder: (context, index) {
              var attraction = filteredAttractions[index];
              bool isLiked =
                  widget.likedAttractions.contains(attraction['name']);
              return AttractionTile(
                attraction: attraction,
                isLiked: isLiked,
                toggleLike: widget.toggleLike,
              );
            },
          ),
        ),
      ],
    );
  }
}

class LikesPage extends StatelessWidget {
  final List<String> likedAttractions;
  final Function toggleLike;
  LikesPage(this.likedAttractions, this.toggleLike);

  @override
  Widget build(BuildContext context) {
    if (likedAttractions.isEmpty) {
      return Center(
        child: Text(
          "Aucune attraction likée.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return FutureBuilder(
      future: rootBundle.loadString('assets/attractions.json'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List attractions = json.decode(snapshot.data!);
        List likedAttractionDetails = attractions
            .where(
                (attraction) => likedAttractions.contains(attraction['name']))
            .toList();

        return ListView.builder(
          itemCount: likedAttractionDetails.length,
          itemBuilder: (context, index) {
            var attraction = likedAttractionDetails[index];
            return AttractionTile(
              attraction: attraction,
              isLiked: true,
              toggleLike: toggleLike,
            );
          },
        );
      },
    );
  }
}

class AttractionTile extends StatelessWidget {
  final Map attraction;
  final bool isLiked;
  final Function toggleLike;

  AttractionTile({
    required this.attraction,
    required this.isLiked,
    required this.toggleLike,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(attraction['image']),
        title: Text(attraction['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(attraction['type']),
            Text("Parc : ${attraction['park']}",
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : null,
          ),
          onPressed: () => toggleLike(attraction['name']),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(attraction['name']),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.network(
                        attraction['image'],
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    InfoRow("Type", attraction['type']),
                    InfoRow("Fabricant", attraction['manufacturer']),
                    InfoRow("Parc", attraction['park']),
                    InfoRow("Localisation", attraction['location']),
                    InfoRow("Année d'ouverture",
                        attraction['opening_year']?.toString()),
                    InfoRow("Hauteur (m)", attraction['height_m']?.toString()),
                    InfoRow(
                        "Vitesse (km/h)", attraction['speed_kmh']?.toString()),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Fermer'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value ?? "Non disponible"),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "À propos de l'application",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Cette application vous permet d'explorer une base de données sur les montagnes russes et autres attractions à sensations. Vous pouvez parcourir la liste des attractions, les filtrer selon différents critères et enregistrer vos favoris. Vous pouvez retrouver vos favroris dans l'onglet prévu à cet effet.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            "Filtres disponibles :",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "- Type : Permet de filtrer les attractions selon leur catégorie (Ex : Steel Coaster, Hybrid Coaster, Dark Ride ...).",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "- Constructeur : Affiche uniquement les attractions fabriquées par un constructeur spécifique.",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "- Parc : Permet de voir les attractions situées dans un parc précis.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 50),
          Text(
            "Attention : les photos sont stockées en ligne sur Imgur, et ne sont donc pas accessibles si vous êtes hors ligne.\n\nCe projet a été réalisé par Adam SALEK - FISE 2026\nP5-AMSE TP1 Flutter",
            style: TextStyle(
                fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
