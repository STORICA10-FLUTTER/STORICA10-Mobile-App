import 'package:flutter/material.dart';
import 'package:storica/models/buku.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:storica/modul-preview/preview-kreasi.dart';
import 'package:storica/modul-preview/preview.dart';

class BukuInggris extends StatefulWidget {
  const BukuInggris({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BukuInggrisState createState() => _BukuInggrisState();
}

class _BukuInggrisState extends State<BukuInggris> {
  Future<List<Buku>> fetchBukuKreasi() async {
    var url = Uri.parse('https://storica.up.railway.app/bukubing-json/');
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreviewPage(
                              gambar: snapshot.data![index].fields.gambar,
                              judul: snapshot.data![index].fields.judul,
                              penerbit: snapshot.data![index].fields.penerbit,
                              pk: snapshot.data![index].pk,
                              isiBuku: snapshot.data![index].fields.isiBuku,
                            ),
                          ),
                        );
                      },
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
