import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider with ChangeNotifier {
  final Set<String> _bookmarkedItems = <String>{};
  static const String _storageKey = 'bookmarked_items';

  BookmarkProvider() {
    _loadBookmarks();
  }

  Set<String> get bookmarkedItems => _bookmarkedItems;

  bool isBookmarked(String itemId) => _bookmarkedItems.contains(itemId);

  Future<void> toggleBookmark(String itemId) async {
    if (_bookmarkedItems.contains(itemId)) {
      _bookmarkedItems.remove(itemId);
    } else {
      _bookmarkedItems.add(itemId);
    }
    notifyListeners();
    await _saveBookmarks();
  }

  Future<void> _loadBookmarks() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> bookmarks = prefs.getStringList(_storageKey) ?? <String>[];
      _bookmarkedItems.addAll(bookmarks);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading bookmarks: \$e');
    }
  }

  Future<void> _saveBookmarks() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_storageKey, _bookmarkedItems.toList());
    } catch (e) {
      debugPrint('Error saving bookmarks: \$e');
    }
  }
}