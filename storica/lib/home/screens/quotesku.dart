import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:storica/home/models/quotes.dart';
import 'package:storica/home/widgets/detail.dart';

class QuotesKuList extends StatefulWidget {
  const QuotesKuList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuotesKuListState createState() => _QuotesKuListState();
}

class _QuotesKuListState extends State<QuotesKuList> {
  Future<List<Quotes>> fetchquotesku() async {
    var url = Uri.parse('http://localhost:8000/myquotes-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Quotes> listQuotes = [];
    for (var d in data) {
      if (d != null) {
        listQuotes.add(Quotes.fromJson(d));
      }
    }
    return listQuotes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        height: 50,
        elevation: 1,
      ),
      appBar: AppBar(
        title: const Text(
          "QuotesKu",
          textAlign: TextAlign.center,
          style: TextStyle(
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
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 35, 34, 33)),
      ),
      body: FutureBuilder(
        future: fetchquotesku(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Belum ada quotes",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(
                      "${snapshot.data![index].fields.kataKata}",
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuotesDetail(
                            quotes: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(200, 134, 104, 85),
                      ),
                      onPressed: () {
                        setState(() async {
                          var url = Uri.parse(
                              'http://localhost:8000/hapus-quote/${snapshot.data.pk}');
                          await http.get(
                            url,
                            headers: {"Content-Type": "application/json"},
                          );
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Quotes berhasi dihapus"),
                          ));
                          fetchquotesku();
                        });
                      },
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
