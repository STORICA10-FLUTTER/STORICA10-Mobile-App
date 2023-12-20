import 'package:flutter/material.dart';
import 'package:storica/modul-baca/baca-kreasi.dart';
import 'package:storica/modul-baca/baca.dart';

class PreviewPageKreasi extends StatelessWidget {
  final String gambar;
  final String judul;
  final String penerbit;
  final String isiBuku;
  final int pk;

  PreviewPageKreasi(
      {Key? key,
      required this.gambar,
      required this.judul,
      required this.penerbit,
      required this.isiBuku, required this.pk})
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
                    builder: (context) => BacaPageKreasi(isiBuku: isiBuku, pk: pk, judul: judul),
                  ),
                );
              },
              child: Text('Baca'),
            ),
            Image.network(gambar), // Display the image
            Text(judul,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(penerbit),
            Text(pk.toString()),
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
