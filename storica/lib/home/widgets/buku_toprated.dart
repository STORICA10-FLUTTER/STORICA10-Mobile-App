import 'package:flutter/material.dart';
import 'package:storica/models/buku.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BukuRated extends StatefulWidget {
  const BukuRated({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BukuRatedState createState() => _BukuRatedState();
}

class _BukuRatedState extends State<BukuRated> {
  Future<List<Buku>> fetchBukuKreasi() async {
    var url = Uri.parse('http://localhost:8000/bukutop-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Buku> list_buku_kreasi = [];
    for (var d in data) {
      if (d != null) {
        list_buku_kreasi.add(Buku.fromJson(d));
      }
    }
    return list_buku_kreasi;
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: fetchBukuKreasi(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          } else {
            if (!snapshot.hasData) {
              return const SizedBox(height: 0);
            } else {
              return SizedBox(
                height: 192,
                width: lebar * 0.9,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1.0,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () => print(snapshot.data![index].fields.judul),
                      child: SizedBox(
                        width: 120,
                        height: 192,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                              image: NetworkImage(
                                  snapshot.data![index].fields.gambar),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        });
  }
}