import 'package:flutter/material.dart';
import 'package:storica/home/models/quotes.dart';

class QuotesDetail extends StatelessWidget {
  const QuotesDetail({super.key, required this.quotes});

  final Quotes quotes;

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quotesku'),
        ),
        body: Container(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text(quotes.fields.kataKata,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(lebar - 84, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 134, 104, 85),
                          foregroundColor:
                              const Color.fromARGB(255, 227, 224, 222),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Kembali',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
