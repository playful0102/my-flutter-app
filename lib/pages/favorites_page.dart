import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<dynamic> favorites;

  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: Center(
          child: Text(
            'No favorites yet.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4.0,
            child: ListTile(
              leading: Image.asset(
                'pictures/${item['image']}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item['headline'] ?? 'No headline'),
              subtitle: Text(item['summary'] ?? 'No summary available'),
            ),
          );
        },
      ),
    );
  }
}

