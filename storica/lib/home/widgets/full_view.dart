import 'package:flutter/material.dart';
import 'package:storica/models/buku.dart';
import 'package:storica/models/buku_kreasi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:storica/variables.dart';

class ViewBuku extends StatefulWidget {
  const ViewBuku({Key? key, required this.listparr}) : super(key: key);

  final String listparr;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ViewBukuState createState() => _ViewBukuState(listparr);
}

class _ViewBukuState extends State<ViewBuku> {
  _ViewBukuState(this.kriteria);
  final String kriteria;

  Future<List<Buku>> fetchBukuSemua() async {
    var url = Uri.parse('http://localhost:8000/buku-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Buku> list_buku = [];
    for (var d in data) {
      if (d != null) {
        list_buku.add(Buku.fromJson(d));
      }
    }
    return list_buku;
  }

  Future<List<BukuKreasi>> fetchBukuKreasi() async {
    var url = Uri.parse('http://localhost:8000/bukukreasi-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<BukuKreasi> list_buku_kreasi = [];
    for (var d in data) {
      if (d != null) {
        list_buku_kreasi.add(BukuKreasi.fromJson(d));
      }
    }
    return list_buku_kreasi;
  }

  Future<List<BukuKreasi>> fetchBukuKreasiKu() async {
    var url = Uri.parse('http://localhost:8000/kreasiku-json/$nama');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<BukuKreasi> list_buku_kreasi = [];
    for (var d in data) {
      if (d != null) {
        list_buku_kreasi.add(BukuKreasi.fromJson(d));
      }
    }
    return list_buku_kreasi;
  }

  Future<List<Buku>> fetchBukuTop() async {
    var url = Uri.parse('http://localhost:8000/bukutop-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Buku> list_buku_kreasi = [];
    for (var d in data) {
      if (d != null) {
        list_buku_kreasi.add(Buku.fromJson(d));
      }
    }
    return list_buku_kreasi;
  }

  Future<List<Buku>> fetchBukuInggris() async {
    var url = Uri.parse('http://localhost:8000/bukubing-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
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
    Future<dynamic> dicoba = fetchBukuInggris();

    if (kriteria == "Buku Rating Tertinggi") {
      dicoba = fetchBukuTop();
    } else if (kriteria == "Koleksi Kami") {
      dicoba = fetchBukuSemua();
    } else if (kriteria == "Karya Pengguna") {
      dicoba = fetchBukuKreasi();
    } else if (kriteria == "Karyaku") {
      dicoba = fetchBukuKreasi();
    }

    return FutureBuilder(
      future: dicoba,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else {
          if (snapshot.data.length == 0) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    kriteria,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 35, 34, 33),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0.5),
                    child: Container(
                      color: Colors.grey,
                      height: 0.5,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: const IconThemeData(
                      color: Color.fromARGB(255, 35, 34, 33)),
                ),
                body: Center(
                  child: Text("$nama, mari menulis!",
                      style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none)),
                ));
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  kriteria,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 35, 34, 33),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.5),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme:
                    const IconThemeData(color: Color.fromARGB(255, 35, 34, 33)),
              ),
              body: GridView.count(
                padding: const EdgeInsets.all(30),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
                childAspectRatio: (120 / 192),
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    return GestureDetector(
                      onTap: () => print(snapshot.data![index].fields.judul),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Image(
                                image: NetworkImage(
                                    snapshot.data![index].fields.gambar),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                color: const Color.fromARGB(255, 134, 104, 85),
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 15, right: 10, bottom: 5),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            snapshot.data![index].fields.judul,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Arial Black',
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.left),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "Penulis :  ${snapshot.data![index].fields.penulis}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0,
                                            ),
                                            textAlign: TextAlign.left),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "Nilai      :  ${snapshot.data![index].fields.rating}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0,
                                            ),
                                            textAlign: TextAlign.left),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ));
        }
      },
    );
  }
}
