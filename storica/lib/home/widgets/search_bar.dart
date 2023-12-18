import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storica/functions/bold_substring.dart';
import 'dart:convert';
import 'package:storica/models/buku.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearchBar> {
  List<Buku> dicari = [];
  Future<List<Buku>> fetchBuku() async {
    var url = Uri.parse('http://localhost:8000/buku-json/');
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
    dicari = list_buku;
    // ignore: unused_local_variable
    return list_buku;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchBuku(),
        builder: (context, AsyncSnapshot snapshot) {
          return SearchAnchor(
              viewElevation: 0,
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  elevation: const MaterialStatePropertyAll<double>(0),
                  shape: const MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  leading: const Icon(color: Colors.grey, Icons.search_rounded),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  hintText: "Cari judul atau penulis buku",
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                String cari = controller.text;
                fetchBuku();
                List<Buku> digunakan = dicari.where((buku) {
                  if (cari != '') {
                    return buku.fields.judul
                            .toLowerCase()
                            .contains(cari.toLowerCase()) ||
                        buku.fields.penulis
                            .toLowerCase()
                            .contains(cari.toLowerCase());
                  }
                  return false;
                }).toList();

                return List<ListTile>.generate(digunakan.length, (int index) {
                  final Buku item = digunakan[index];
                  return ListTile(
                    title: Text(item.fields.judul)
                        .boldSubString(cari, const TextStyle()),
                    subtitle: Text("Penulis: ${item.fields.penulis}")
                        .boldSubString(cari, const TextStyle(fontSize: 10)),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    onTap: () {
                      setState(
                        () {
                          controller.closeView('');
                          print(item.fields.judul);
                        },
                      );
                    },
                  );
                }, growable: true);
              });
        });
  }
}
