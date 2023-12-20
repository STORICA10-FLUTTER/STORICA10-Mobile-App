import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:storica/home/models/quotes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuotesList extends StatefulWidget {
  const QuotesList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<QuotesList> {
  Future<List<Quotes>> fetchQuotes() async {
    var url = Uri.parse('https://storica.up.railway.app/quotes-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Quotes> list_Quotes = [];
    for (var d in data) {
      if (d != null) {
        list_Quotes.add(Quotes.fromJson(d));
      }
    }

    return list_Quotes;
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: fetchQuotes(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          } else {
            if (!snapshot.hasData) {
              return Container(
                  constraints: BoxConstraints(maxHeight: 120, minWidth: lebar),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      "\"Buku adalah jendela dunia. Melalui setiap halaman, kita dapat menjelajahi tanpa batas. Bacalah, dan temukan keajaiban di dunia yang tercipta oleh kata-kata.\"\n~Soe Hok Gie",
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ));
            }
            return Container(
                constraints: BoxConstraints(
                    maxHeight: 120, minWidth: lebar, minHeight: 0),
                child: CarouselSlider(
                    options: CarouselOptions(
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 8),
                    ),
                    items: [
                      const Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Text(
                          "\"Buku adalah jendela dunia. Melalui setiap halaman, kita dapat menjelajahi tanpa batas. Bacalah, dan temukan keajaiban di dunia yang tercipta oleh kata-kata.\"\n~Soe Hok Gie",
                          style: TextStyle(
                            fontFamily: 'Calibri',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      for (var i = 0; i < snapshot.data!.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            "\"${snapshot.data![i].fields.kataKata}\"",
                            style: const TextStyle(
                              fontFamily: 'Calibri',
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ]));
          }
        });
  }
}
