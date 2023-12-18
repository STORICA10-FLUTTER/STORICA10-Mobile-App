import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:storica/home/screens/write.dart';

class TulisQuotes extends StatefulWidget {
  const TulisQuotes({super.key});

  @override
  _TulisQuotesState createState() => _TulisQuotesState();
}

class _TulisQuotesState extends State<TulisQuotes> {
  final _formKey = GlobalKey<FormState>();
  String _kata = "";
  Color warna = Colors.black;

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tulis Quotes",
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Tulis quotesmu di sini!",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: TextFormField(
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: "Quotesmu",
                    labelText: "Quotesmu",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _kata = value!;
                      if (_kata.length >= 180) {
                        warna = Colors.red;
                      } else {
                        warna = Colors.black;
                      }
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama tidak boleh kosong!";
                    } else if (value.length >= 180) {
                      return "Jumlah karakter tidak boleh lebih dari 180!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${_kata.length}/180",
                    style: TextStyle(color: warna, fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(lebar, 40),
                      backgroundColor: const Color.fromARGB(255, 134, 104, 85),
                      foregroundColor: const Color.fromARGB(255, 227, 224, 222),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                            'http://localhost:8000/create-quote/',
                            jsonEncode(<String, String>{
                              'kata_kata': _kata,
                            }));
                        if (response['status'] == 'success') {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Quotesmu berhasil disimpan!"),
                          ));
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Make()),
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
                          ));
                        }
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
