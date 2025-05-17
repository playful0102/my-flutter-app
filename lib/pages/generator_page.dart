import 'package:flutter/material.dart';
import 'home.dart';
import 'favorites_page.dart';
import 'test.dart';
import 'news_page.dart';
import 'setting.dart';

class MyGeneratorPage extends StatefulWidget {
  @override
  State<MyGeneratorPage> createState() => _MyGeneratorPageState();
}

class _MyGeneratorPageState extends State<MyGeneratorPage> {
  var selectedIndex = 0;
  final PageController _pageController = PageController();  
  final Set<dynamic> bookmarkedItems = {};

  void _toggleBookmark(dynamic item) {
    setState(() {
      if (bookmarkedItems.any((existing) => existing['headline'] == item['headline'])) {
        bookmarkedItems.removeWhere((existing) => existing['headline'] == item['headline']);
      } else {
        bookmarkedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('TESTING App'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFC0CB),  // Light pink color
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          children: [
            HomePage(),
            FavoritesPage(
              favorites: bookmarkedItems.toList(),
              onRemoveBookmark: (item) {
                setState(() {
                  bookmarkedItems.remove(item);
                });
              },
            ),
            TestPage(),
            NewsPage(
              onBookmarkChanged: _toggleBookmark,
              initialBookmarks: bookmarkedItems,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
       currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          _pageController.animateToPage(
            // Add animation here
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: 'Test',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
