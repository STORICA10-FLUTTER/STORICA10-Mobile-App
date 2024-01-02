import 'package:flutter/material.dart';
import 'package:storica/modul-baca/models/komentar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// TODO: bisa ubah ke Stateful biar autorefresh commentnya (for now harus back dlu baru go in lg)
class BacaPage extends StatelessWidget {
  final TextEditingController _commentController = TextEditingController();
  String _selectedRating = '1'; // Default rating

  final String isiBuku;
  final int pk;
  final String judul;

  BacaPage(
      {Key? key,
      required this.isiBuku,
      required this.pk, required this.judul})
      : super(key: key);

  Future<List<Komentar>> fetchKomentar() async {
    try {
      var url =
          Uri.parse('https://storica.up.railway.app/preview/baca/json-komentar/$pk/');
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      List<Komentar> listKomentar = [];
      for (var d in data) {
        if (d != null) {
          listKomentar.add(Komentar.fromJson(d));
        }
      }
      return listKomentar;
    } catch (e) {
      print("Error occurred: $e");
      return []; // return an empty list on error
    }
  }
  
  Future<void> _submitComment(String isiKomentar, String rating) async {
    var url = Uri.parse(
        'https://storica.up.railway.app/preview/baca/create-komentar-flutter/'); // Replace with your API endpoint
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "isi_komentar": isiKomentar,
        "rating": _selectedRating,
        "dari_buku": pk,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Optionally, show a success message
      _commentController.clear(); // Clear the text field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baca & Komentar'),
      ),
      body: FutureBuilder(
        future: fetchKomentar(),
        builder: (context, AsyncSnapshot snapshot) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Container for isiBuku
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100, // Light blue color
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isiBuku,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),

                // Comments Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Comments",
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),

                // Inside the build method, after the Comments list
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Add a Comment",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: "Write your comment here...",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Rating',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedRating,
                    items: List<DropdownMenuItem<String>>.generate(
                      5,
                      (index) => DropdownMenuItem(
                        value: '${index + 1}',
                        child: Text('${index + 1}'),
                      ),
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _selectedRating = newValue;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _submitComment(
                        _commentController.text, _selectedRating),
                    child: const Text('Submit Comment'),
                  ),
                ),

                // Comments List
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Center(child: CircularProgressIndicator())
                else if (snapshot.data == null || snapshot.data!.isEmpty)
                  const Text(
                    "Jadilah yang pertama berkomentar!",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      // Comment Card
                      return Card(
                        // TODO: taro gambar anonymous
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Anonymous", // Replace with actual username
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                  "Rating: ${snapshot.data![index].fields.rating}"),
                              const SizedBox(height: 8),
                              Text(DateFormat('yyyy-MM-dd').format(
                                  snapshot.data![index].fields.tglKomentar)),
                              const SizedBox(height: 8),
                              Text(snapshot.data![index].fields.isiKomentar),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
