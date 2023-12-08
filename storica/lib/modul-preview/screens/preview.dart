import 'package:flutter/material.dart';
import 'package:storica/modul-baca/baca.dart';

class PreviewPage extends StatelessWidget {
  final String gambar;
  final String judul;
  final String penerbit;
  final String isiBuku;

  PreviewPage(
      {Key? key,
      required this.gambar,
      required this.judul,
      required this.penerbit,
      required this.isiBuku})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to BacaPage with isiBuku as an argument
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BacaPage(isiBuku: isiBuku),
                  ),
                );
              },
              child: Text('Baca'),
            ),
            Image.network(gambar), // Display the image
            Text(judul,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(penerbit),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home screen
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
