import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storica/login.dart';
import 'package:storica/models/buku.dart';
import 'package:storica/modul-baca/baca.dart';
import 'package:storica/variables.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Buku> favoriteBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {



    try {
      var url = Uri.parse('http://127.0.0.1:8000/favorites/show_favorites_json/$nama');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          favoriteBooks = jsonData.map((data) => Buku.fromJson(data)).toList();
          isLoading = false;
        });
      } else {
        print('Failed to fetch favorites. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching favorites: $error');
    }
  }

  // TODO: Implement logic to remove a book from favorites
  void removeFromFavorites(int pk) async {

    // TODO: Make an API call to remove the book from favorites using the `pk` and `token`
    // Example API call:
    var url = Uri.parse('http://127.0.0.1:8000/favorites/remove_from_favorites/$nama/$pk');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    // If the API call is successful, you can update the UI accordingly
    // Example code:
    if (response.statusCode == 200) {
      // Remove the book from the `favoriteBooks` list
      setState(() {
        favoriteBooks.removeWhere((book) => book.pk == pk);
      });
    } else {
      print('Failed to remove from favorites. Status code: ${response.statusCode}');
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buku Favorit',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 35, 34, 33),
          ),
        ),
      ), // Added missing comma here
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : favoriteBooks.isEmpty
              ? Center(child: Text('Tidak ada buku favorit.'))
              : ListView.builder(
                  itemCount: favoriteBooks.length,
                  itemBuilder: (context, index) {
                    var favoriteBook = favoriteBooks[index]; // Assuming favoriteBook is correctly structured
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Image
                            Image.network(favoriteBook.fields.gambar),
                            // Title
                            Text(
                              favoriteBook.fields.judul,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            // Author
                            Text('Author: ${favoriteBook.fields.penulis}'),
                            SizedBox(height: 8),
                            // Publishing Company
                            Text('Publisher: ${favoriteBook.fields.penerbit}'),
                            SizedBox(height: 8),
                            // Language
                            Text('Language: ${favoriteBook.fields.bahasa}'),
                            IconButton(
                              icon: Icon(Icons.bookmark, color: Color.fromARGB(255, 134, 104, 85)),
                              onPressed: () {
                                removeFromFavorites(favoriteBook.pk); // Ensure this function is defined and works as expected
                                setState(() {
                                  favoriteBooks.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}