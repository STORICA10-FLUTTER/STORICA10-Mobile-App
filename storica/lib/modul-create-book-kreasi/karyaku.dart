// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storica/models/buku_kreasi.dart';
import 'package:storica/modul-create-book-kreasi/form.dart';

class ShowKaryaku extends StatefulWidget {
  const ShowKaryaku({super.key});

  @override
  State<ShowKaryaku> createState() => _ShowKaryakuState();
}

class _ShowKaryakuState extends State<ShowKaryaku> {
  @override
  void initState() {
    super.initState();
    fetchKaryaku();
  }

  List<BukuKreasi> listKaryaku = [];
  Future<void> fetchKaryaku() async {
    var url = Uri.parse("https://storica.up.railway.app/bukukreasi-json/");
    var response =
        await http.get(url, headers: {"Content-type": "application/json"});
    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    setState(() {
      listKaryaku = (data.map((buku) => BukuKreasi.fromJson(buku)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: listKaryaku.length,
                  itemBuilder: (context, index) {
                    BukuKreasi buku = listKaryaku[index];
                    return ListTile(
                      title: Text(buku.fields.judul),
                      subtitle: Text("Penulis: ${buku.fields.penulis}"),
                      // Add more ListTile content based on your needs
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
