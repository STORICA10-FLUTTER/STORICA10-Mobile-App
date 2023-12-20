import 'package:flutter/material.dart';
import 'package:storica/modul-baca/baca.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:storica/variables.dart';

class PreviewPage extends StatefulWidget {
  final String gambar;
  final String judul;
  final String penerbit;
  final String isiBuku;
  final int pk;

  PreviewPage({
    Key? key,
    required this.gambar,
    required this.judul,
    required this.penerbit,
    required this.isiBuku,
    required this.pk,
  }) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  bool isFavorite = false; // Initial favorite state

  @override
  void initState() {
    super.initState();
    // Check if the book is already in favorites
    checkIfBookIsFavorite(widget.pk);
  }

  Future<void> checkIfBookIsFavorite(int pk) async {

    // TODO: Make an API call to remove the book from favorites using the `pk` and `token`
    // Example API call:
    var url = Uri.parse('http://127.0.0.1:8000/favorites/check_favorite/$nama/$pk');
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        isFavorite = data['is_favorite'] ?? false;
      });
    } else {
      throw Exception('Failed to check if the book is a favorite.');
    }
  }


  Future<void> toggleFavorite() async {
    // Update the favorite status
    setState(() {
      isFavorite = !isFavorite;
    });

    var url = Uri.parse('http://127.0.0.1:8000/favorites' +
        (isFavorite ? '/add_to_favorites/' : '/remove_from_favorites/') + '${nama}/'
        '${widget.pk}');

    var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );


                            

    // Check the response status
    if (response.statusCode != 200) {
      setState(() {
        isFavorite = !isFavorite; // Revert the favorite status on failure
      });
      throw Exception(
          'Failed to ${isFavorite ? 'add' : 'remove'} the book from favorites. Status: ${response.statusCode}');
    }
  }



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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BacaPage(
                      isiBuku: widget.isiBuku,
                      pk: widget.pk,
                      judul: widget.judul,
                    ),
                  ),
                );
              },
              child: Text('Baca'),
            ),
            Image.network(widget.gambar),
            Text(widget.judul,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(widget.penerbit),
            Text(widget.pk.toString()),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.bookmark : Icons.bookmark_outline_outlined,
                color: const Color.fromARGB(255, 134, 104, 85),
              ),
              onPressed: toggleFavorite,
            ),
            ElevatedButton(
              onPressed: () {
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
