import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:storica/models/buku.dart';
import 'package:storica/models/buku_kreasi.dart';
import 'package:storica/modul-preview/preview-kreasi.dart';
import 'package:storica/modul-preview/preview.dart';

class HomePageBuku extends StatefulWidget {
  const HomePageBuku({Key? key}) : super(key: key);

  @override
  HomePageBukuState createState() => HomePageBukuState();
}

class HomePageBukuState extends State<HomePageBuku>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<List<Buku>> fetchBuku() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse('http://127.0.0.1:8000/buku-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Buku
    List<Buku> listBuku = [];
    for (var d in data) {
      if (d != null) {
        listBuku.add(Buku.fromJson(d));
      }
    }
    return listBuku;
  }

  Future<List<BukuKreasi>> fetchBukuKreasi() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse('http://127.0.0.1:8000/bukukreasi-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Buku
    List<BukuKreasi> listBukuKreasi = [];
    for (var d in data) {
      if (d != null) {
        listBukuKreasi.add(BukuKreasi.fromJson(d));
      }
    }
    return listBukuKreasi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Buku'),
            Tab(text: 'Buku Kreasi'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildBukuList(), // Function to build list for Buku
          buildBukuKreasiList(), // Function to build list for Buku Kreasi
        ],
      ),
    );
  }

  Widget buildBukuList() {
    return FutureBuilder(
        future: fetchBuku(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data produk.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PreviewPage(
                                      gambar:
                                          snapshot.data![index].fields.gambar,
                                      judul: snapshot.data![index].fields.judul,
                                      penerbit:
                                          snapshot.data![index].fields.penerbit,
                                      isiBuku:
                                          snapshot.data![index].fields.isiBuku,
                                      pk: snapshot.data![index].pk,
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                "${snapshot.data![index].fields.gambar}",
                              ),
                            ),
                            Text(
                              "${snapshot.data![index].fields.judul}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.penerbit}"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.bahasa}")
                          ],
                        ),
                      ));
            }
          }
        });
  }

  Widget buildBukuKreasiList() {
    return FutureBuilder(
        future: fetchBukuKreasi(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data produk.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PreviewPageKreasi(
                                      gambar:
                                          snapshot.data![index].fields.gambar,
                                      judul: snapshot.data![index].fields.judul,
                                      penerbit:
                                          snapshot.data![index].fields.penerbit,
                                      isiBuku:
                                          snapshot.data![index].fields.isiBuku,
                                      pk: snapshot.data![index].pk,
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                "${snapshot.data![index].fields.gambar}",
                              ),
                            ),
                            Text(
                              "${snapshot.data![index].fields.judul}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.penerbit}"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.bahasa}")
                          ],
                        ),
                      ));
            }
          }
        });
  }
}
