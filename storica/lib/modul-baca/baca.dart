import 'package:flutter/material.dart';

class BacaPage extends StatelessWidget {
  final String isiBuku; // Add this line

  // Add this constructor
  BacaPage({Key? key, required this.isiBuku}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baca Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isiBuku, // Display isiBuku here
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

