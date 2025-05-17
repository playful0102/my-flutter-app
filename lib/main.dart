import 'package:flutter/foundation.dart'; // Import for kReleaseMode
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'pages/generator_page.dart';

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
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: MyGeneratorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



