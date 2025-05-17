import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final String headline;
  final String content;
  final String imagePath; // Add imagePath parameter

  const NewsDetailPage({
    super.key,
    required this.headline,
    required this.content,
    required this.imagePath, // Make imagePath required
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headline),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'pictures/$imagePath',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headline,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 16.0),
                  Text(content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}