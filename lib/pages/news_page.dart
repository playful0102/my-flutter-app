import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'news_detail_page.dart';

class NewsPage extends StatefulWidget {
  final Function(dynamic) onBookmarkChanged;
  final Set<dynamic> initialBookmarks;
  
  const NewsPage({
    super.key, 
    required this.onBookmarkChanged,
    required this.initialBookmarks,
  });

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<Map<String, dynamic>> newsItems = [];
  Set<String> bookmarkedItems = {}; // Use Set<String> instead of Set<dynamic>

  @override
  void initState() {
    super.initState();
    bookmarkedItems = Set<String>.from(widget.initialBookmarks.map((item) => item['headline'] as String));
    _loadNewsData();
  }

  @override
  void didUpdateWidget(covariant NewsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialBookmarks != oldWidget.initialBookmarks) {
      setState(() {
        bookmarkedItems = Set<String>.from(widget.initialBookmarks.map((item) => item['headline'] as String));
      });
    }
  }
  void _toggleBookmark(Map<String, dynamic> item) {
    setState(() {
      final String headline = item['headline'] as String;
      if (bookmarkedItems.contains(headline)) {
        bookmarkedItems.remove(headline);
      } else {
        bookmarkedItems.add(headline);
      }
      widget.onBookmarkChanged(item);
    });
  }

  Future<void> _loadNewsData() async {
    final String response = await rootBundle.loadString('pictures_data.json');
    setState(() {
      newsItems = List<Map<String, dynamic>>.from(json.decode(response) as List);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search news...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value.toLowerCase();
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: newsItems.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> item = newsItems[index];
              final String headline = item['headline'] as String;
              final String summary = item['summary'] as String;
              final String fullContent = item['detailed_summary'] as String;

              if (_searchText.isNotEmpty &&
                  !headline.toLowerCase().contains(_searchText) &&
                  !summary.toLowerCase().contains(_searchText)) {
                return Container();
              }

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                child: Column(
                  children: [
                    Image.asset(
                      'pictures/${item['image']}',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headline,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            summary,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetailPage(
                                        headline: headline,
                                        content: fullContent,
                                        imagePath: item['image'] as String,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Read More'),
                              ),
                              IconButton(
                                icon: Icon(
                                  bookmarkedItems.contains(item['headline']) ? Icons.bookmark : Icons.bookmark_border,
                                  color: bookmarkedItems.contains(item['headline']) ? Colors.blue : null,
                                ),
                                onPressed: () => _toggleBookmark(item),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
