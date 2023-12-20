import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storica/models/buku.dart';
import 'dart:convert';

import 'package:storica/modul-preview/preview.dart';

class BukuTrend extends StatefulWidget {
  const BukuTrend({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BukuTrendState createState() => _BukuTrendState();
}

class _BukuTrendState extends State<BukuTrend> {
  Future<List<Buku>> fetchBuku() async {
    var url = Uri.parse('http://localhost:8000/bukutrending-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Buku> list_buku = [];
    for (var d in data) {
      if (d != null) {
        list_buku.add(Buku.fromJson(d));
      }
    }
    return list_buku;
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: fetchBuku(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          } else {
            return SizedBox(
                height: 300,
                width: lebar,
                child: CarouselSlider(
                    options: CarouselOptions(viewportFraction: 1),
                    items: [
                      for (var i = 0; i < 10; i++)
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: SizedBox(
                            height: 300,
                            width: lebar,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PreviewPage(
                                      gambar: snapshot.data![i].fields.gambar,
                                      judul: snapshot.data![i].fields.judul,
                                      penerbit:
                                          snapshot.data![i].fields.penerbit,
                                      pk: snapshot.data![i].pk,
                                      isiBuku: snapshot.data![i].fields.isiBuku,
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 15, bottom: 15),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 250,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              snapshot.data![i].fields.gambar,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 30),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30 -
                                                    30 -
                                                    250,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data![i].fields.judul,
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Arial Black',
                                                      letterSpacing: 0,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        "${snapshot.data![i].fields.penulis}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left),
                                                  ),
                                                  const SizedBox(
                                                    height: 2.5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        "Nilai: ${snapshot.data![i].fields.rating}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left),
                                                  ),
                                                  const SizedBox(
                                                    height: 2.5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        "Bahasa: ${snapshot.data![i].fields.bahasa}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ]));
          }
        });
  }
}
