import 'package:flutter/material.dart';
import 'package:storica/home/screens/tulis_quotes.dart';
import 'package:storica/modul-create-book-kreasi/form.dart';
import 'package:storica/variables.dart';

class Make extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Menulis',
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
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 35, 34, 33)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        nama,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 134, 104, 85),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text(
                        "Tulis karyamu Di sini!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 134, 104, 85),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Icon(
                    Icons.edit_outlined,
                    size: 300,
                    color: Color.fromARGB(255, 134, 104, 85),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: lebar * 0.9,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TulisQuotes(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 134, 104, 85),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Tulis Quotes',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: lebar * 0.9,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Item_Form(
                            judul: '',
                            halaman: 0,
                            bahasa: '',
                            penerbit: '',
                            penulis: '',
                            dateData: '',
                            imageData: '',
                          );
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(255, 134, 104, 85),
                      ),
                      child: const Text(
                        'Tulis Buku',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
