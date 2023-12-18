import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:storica/functions/image_check.dart';
import 'package:storica/home/screens/profile_page.dart';
import 'package:storica/variables.dart';
import 'dart:convert';

class UbahProfil extends StatefulWidget {
  const UbahProfil({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UbahProfilState createState() => _UbahProfilState();
}

class _UbahProfilState extends State<UbahProfil> {
  final _formKey = GlobalKey<FormState>();
  String _profil = "";
  Color warna = Colors.black;

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ubah Profil",
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
                  "Masukkan link jpg/png/gif profil anda!",
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
                    hintText: "Link profil",
                    labelText: "link profil",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _profil = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Link tidak boleh kosong!";
                    }
                    return null;
                  },
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
                        String pesan = "";
                        if (await validateImage(_profil)) {
                          pesan = "Foto profilmu berhasil diperbarui!";
                        } else {
                          pesan = "Maaf, link yang kamu masukkan tidak valid";
                        }
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(pesan),
                        ));
                      }
                      if (_formKey.currentState!.validate()) {
                        gambarurl = _profil;
                        final response = await request.postJson(
                            'http://localhost:8000/ganti-profil/',
                            jsonEncode(<String, String>{'gambar': gambarurl}));
                        if (response['status'] == 'success') {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Profil baru berhasil disimpan!"),
                          ));
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()),
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
