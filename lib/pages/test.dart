import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});

  final ValueNotifier<String?> _pressedValue = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Test button'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('This is the Test Page'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ValueListenableBuilder<String?>(
              valueListenable: _pressedValue,
              builder: (context, value, child) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    value == null ? 'No button pressed yet' : "Pressed: $value",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _pressedValue.value = 'Button 1',
                  child: Text('Button 1'),
                ),
                ElevatedButton(
                  onPressed: () => _pressedValue.value = 'Button 2',
                  child: Text('Button 2'),
                ),
                ElevatedButton(
                  onPressed: () => _pressedValue.value = 'Button 3',
                  child: Text('Button 3'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}