import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart'; // Import for kReleaseMode
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'favorites_page.dart'; // Import the new favorites page file
import 'test.dart'; // Import the new test page file

void main() => runApp(
      DevicePreview(
        // Only enable DevicePreview in debug mode
        enabled: kDebugMode, // Use kDebugMode instead of !kReleaseMode for clarity
        builder: (context) => MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider should wrap MaterialApp or be placed higher if needed globally
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        // Add DevicePreview settings here
        useInheritedMediaQuery: true, // Recommended for DevicePreview
        locale: DevicePreview.locale(context), // Use DevicePreview locale
        builder: DevicePreview.appBuilder, // Use DevicePreview builder

        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        // Removed darkTheme for simplicity unless specifically needed
        home: MyHomePage(), // Use the existing MyHomePage
      ),
    );
  }
  // Removed the duplicate build method
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[]; // Add a list to hold favorites

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  // Method to toggle favorite status
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

// Convert MyHomePage to StatefulWidget
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0; // State variable for selected index
  var isExtended = false; // State variable for NavigationRail state

  @override
  Widget build(BuildContext context) {
    Widget page; // Widget to display based on selected index
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage(); // Page for index 0
        break;
      case 1:
        page = FavoritesPage(); // Page for index 1 (Now imported)
        break;
      case 2: // Add case for the new TestPage
        page = TestPage(); // Use the imported TestPage
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // Use LayoutBuilder to conditionally change the Scaffold structure based on width
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, // Set AppBar color to white
          title: Text('TESTING App'), // Add a main title to the AppBar
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0), // Add padding to the right
              child: Center(child: Text('testing')), // Add "testing" text to the actions
            ),
          ],
        ),
        body: Row( // Use Row for potential side navigation later
          children: [
            SafeArea( // Ensure navigation rail respects safe areas
              child: NavigationRail(
                extended: isExtended, // Use state variable here
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                  NavigationRailDestination( // Add destination for TestPage
                    icon: Icon(Icons.science), // Example icon
                    label: Text('Test'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value; // Update state on selection
                  });
                },
                // Add a leading widget for the toggle button
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(isExtended ? Icons.menu_open : Icons.menu),
                      tooltip: isExtended ? 'Collapse' : 'Expand',
                      onPressed: () {
                        setState(() {
                          isExtended = !isExtended; // Toggle the state
                        });
                      },
                    ),
                    // Add some space below the button if needed when extended
                    // if (isExtended) SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Expanded( // Main content area takes remaining space
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page, // Display the selected page
              ),
            ),
          ],
        ),
      );
    });
  }
}

// Create the Generator Page (extracted from original MyHomePage body)
class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    // Determine the icon based on whether the current pair is favorited
    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row( // Row for the buttons
            mainAxisSize: MainAxisSize.min, // Shrink row to fit content
            children: [
              ElevatedButton.icon( // Button to toggle favorite
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10), // Space between buttons
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Create the Favorites Page (placeholder)
// REMOVE the FavoritesPage class definition from here
// class FavoritesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//      var appState = context.watch<MyAppState>();
//
//     if (appState.favorites.isEmpty) {
//       return Center(
//         child: Text('No favorites yet.'),
//       );
//     }
//
//     return ListView( // Use ListView to display favorites
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(20),
//           child: Text('You have ${appState.favorites.length} favorites:'),
//         ),
//         for (var pair in appState.favorites)
//           ListTile( // Display each favorite as a ListTile
//             leading: Icon(Icons.favorite),
//             title: Text(pair.asLowerCase),
//           ),
//       ],
//     );
//   }
// }


// BigCard widget remains the same
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

