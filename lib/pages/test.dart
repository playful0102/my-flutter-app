import 'package:flutter/material.dart';

// Convert TestPage to StatefulWidget
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

// Create the State class
class _TestPageState extends State<TestPage> {
  // State variable to hold the pressed button's value
  String? _pressedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Set the background color here
      appBar: AppBar(
        title: Text('Test button'), // Add an AppBar for context
      ),
      // Use Column as the direct body
      body: Column(
        children: [
          // Text at the top
          Padding(
            padding: const EdgeInsets.all(16.0), // Add padding around text
            child: Text('This is the Test Page'),
          ),

          // Box to display the pressed value
          Padding(
            // Consider adding right padding too for symmetry:
            // padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15.0, right: 15.0), // Removed right padding
            child: Container(
              // REMOVE this line: color: Colors.orange,
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center, // Align content to the left
              decoration: BoxDecoration(
                // Keep the color definition here
                color: Colors.white.withOpacity(0.8), // Semi-transparent white box
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                // Display the stored value or a default message
                'You pressed: ${_pressedValue ?? 'None'}',
                style: TextStyle(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center, // Add center alignment
              ),
            ),
          ),

          // Expanded takes up the space in between
          Expanded(
            child: SizedBox(), // Empty space filler
          ),

          // Row of buttons at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Padding below buttons
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center buttons horizontally
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Update state when button 1 is pressed
                    setState(() {
                      _pressedValue = '1';
                    });
                    print('Button 1 pressed');
                  },
                  child: Text('1'),
                ),
                SizedBox(width: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Update state when button 2 is pressed
                    setState(() {
                      _pressedValue = '2';
                    });
                    print('Button 2 pressed');
                  },
                  child: Text('2'),
                ),
                SizedBox(width: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Update state when button 3 is pressed
                    setState(() {
                      _pressedValue = '3';
                    });
                    print('Button 3 pressed');
                  },
                  child: Text('3'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}