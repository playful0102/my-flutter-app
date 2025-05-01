import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart'; // Import to access MyAppState

// Create the Favorites Page (placeholder)
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView( // Use ListView to display favorites
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile( // Display each favorite as a ListTile
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}