# TP1 - Application Flutter : RCDB (Roller Coaster Database)

## Description
Cette application Flutter permet d'explorer une base de données d'attractions (montagnes russes, flat rides, dark rides, etc.). L'utilisateur peut :
- Parcourir la liste des attractions
- Filtrer les attractions par type, constructeur et parc
- Ajouter des attractions en favoris
- Consulter les attractions likées dans un onglet dédié
- Voir des informations détaillées sur chaque attraction

## Structure globale du projet

```
TP1/
│── assets/
│   ├── attractions.json   # Fichier contenant les données des attractions
│── lib/
│   ├── main.dart          # Fichier principal de l'application
│── pubspec.yaml           # Dépendances et configuration du projet
│── README.md              # Documentation du projet
```

## Installation et exécution

1. **Cloner le projet**
   ```sh
   git clone https://github.com/adamsalek3/P5_AMSE/tree/main/tp1
   cd tp1
   ```

2. **Installer les dépendances**
   ```sh
   flutter pub get
   ```

3. **Lancer l'application**
   ```sh
   flutter run
   ```

## Fonctionnalités principales

### Navigation
L'application est composée de 4 onglets accessibles via une `BottomNavigationBar` :
- **Accueil** : Présentation de l'application
- **Attractions** : Liste des attractions avec filtres
- **Favoris** : Liste des attractions likées
- **À Propos** : Informations sur l'application

### Filtres disponibles
L'utilisateur peut filtrer les attractions selon :
- **Type** (Steel Coaster, Wooden Coaster, Flat Ride...)
- **Constructeur** (Gerstlauer, Intamin, B&M...)
- **Parc** (Alton Towers, Europa Park...)

### Données des attractions
Les attractions sont stockées dans `assets/attractions.json`, sous la forme suivante :
```json
{
  "name": "The Smiler",
  "type": "Steel Coaster",
  "image": "https://i.imgur.com/19W0iWA.png",
  "manufacturer": "Gerstlauer",
  "park": "Alton Towers",
  "location": "Staffordshire, Royaume-Uni",
  "opening_year": 2013,
  "height_m": 30,
  "speed_kmh": 85
}
```

## Dépendances principales
L'application utilise :
- `flutter/material.dart` pour l'UI
- `dart:convert` pour la gestion des données JSON
- `flutter/services.dart` pour charger les assets

## Auteur
Projet réalisé par **Adam SALEK** - FISE 2026
dans le cadre de la **P5 - AMSE**

