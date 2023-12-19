// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storica/home/screens/menu.dart';
import 'package:storica/modul-create-book-kreasi/manually_created.dart';

import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';

class Item_Form extends StatefulWidget {
  const Item_Form({super.key});

  @override
  State<Item_Form> createState() => _Item_FormState();
}

class _Item_FormState extends State<Item_Form> {
  static DateTime? dateSelected;
  final _formKey = GlobalKey<FormState>();
  TextEditingController fieldDisplayDateController = TextEditingController();
  TextEditingController fieldHalamanController = TextEditingController();
  TextEditingController fieldBahasaController = TextEditingController();
  TextEditingController fieldPenerbitController = TextEditingController();
  TextEditingController fieldDateController = TextEditingController();
  TextEditingController fieldImageController = TextEditingController();
  TextEditingController fieldJudulController = TextEditingController();

  var judul = null;
  int jumlahHalaman = 0;
  var bahasa = null;
  var penerbit = null;
  var waktuTerbit = null;
  var image = null;
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Form Daftar Item"),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 320,
                  child: Image(
                    loadingBuilder:
                        (context, child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? (loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!)
                              : null,
                        ),
                      );
                    },
                    image: NetworkImage((fieldImageController.text == "")
                        ? "https://plus.unsplash.com/premium_photo-1697368109755-ad5cad60d741?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                        : fieldImageController.text),
                    fit: BoxFit.fill,
                  ),

                  //https://i.pinimg.com/564x/75/e1/23/75e123edb9327e4d0ac1f1c648b4d239.jpg
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                            fieldJudulController.text,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 30),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            fieldPenerbitController.text,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 20),
                          )),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: JudulField(),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: JumlahHalamanField(),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: BahasaField(),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: PenerbitField(),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: ImageField(),
                      ),
                      Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Center(
                                child:
                                    DisplayDateField(fieldDateController.text),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MyHomePage();
                        }));
                      },
                      child: Text("BACK")),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print("jangan kosong");
                          ShowPopup();
                        }

                        var uri = ("http://127.0.0.1:8000/post-buku-kreasi");

                        // salahnya disini
                        var response = await request.postJson(
                            uri,
                            jsonEncode(<String, String>{
                              "judul": fieldJudulController.text,
                              'penerbit': fieldPenerbitController.text,
                              'jumlah_halaman':
                                  fieldHalamanController.text.toString(),
                              'bahasa': fieldBahasaController.text,
                              'tanggal_terbit': fieldDateController.text,
                              'gambar': fieldImageController.text,
                              'is_published': "True"
                            }));
                        print("apakah berhasil");
                        print(judul);
                      },
                      child: Text("NEXT")),
                )
              ],
            )),
      ),
    );
  }

  Future ShowPopup() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Center(child: Text("Choose Your Methode")),
            content: Container(
                height: 300,
                width: 800,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // methode list item
                        Container(
                          height: 200,
                          width: 200,
                          margin: EdgeInsets.fromLTRB(20, 0, 100, 0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(30, 30)),
                              onPressed: null,
                              icon: Icon(Icons.picture_as_pdf),
                              label: Text("Browse Pdf\n(Not Available)")),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3, 0, 20, 0),
                          height: 200,
                          width: 200,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(30, 30)),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ManualCreate();
                                  }),
                                );
                              },
                              icon: Icon(Icons.edit),
                              label: Text("Create Manually")),
                        )
                      ],
                    ),
                  ),
                )),
          ));

  TextFormField JudulField() {
    return TextFormField(
      controller: fieldJudulController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Judul Tidak Boleh Kosong";
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextFormField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Judul Buku",
          label: Text("Judul Buku")),
      onChanged: (value) {
        _formKey.currentState?.validate();
        if (value != "") {
          judul = fieldJudulController.text;
        }
        setState(() {});

        print(fieldJudulController.text);
      },
    );
  }

  TextFormField BahasaField() {
    return TextFormField(
      controller: fieldBahasaController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bahasa Tidak Boleh Kosong";
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextFormField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Bahasa",
          label: Text("Bahasa")),
      onChanged: (value) {
        _formKey.currentState?.validate();

        setState(() {});
        if (value != null && value != "") {
          bahasa = value!;
        }
        print("Deskrpsi : $bahasa");
      },
    );
  }

  TextFormField JumlahHalamanField() {
    int jmlhal = 0;
    return TextFormField(
      controller: fieldHalamanController,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextFormField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Jumlah Halaman",
          label: Text("Jumlah Halaman")),
      validator: (value) {
        if (value!.isEmpty || value == 0 || value == "0") {
          return "Jumlah Halaman Tidak Boleh Kosong atau 0";
        }
      },
      onChanged: (hasil) {
        try {
          jmlhal = int.parse(hasil);
          _formKey.currentState?.validate();
          if (hasil != 0 || hasil != "") {
            jumlahHalaman = jmlhal;
          }
        } catch (e) {
          print("Input yang anda masukan tidak Valid");
        }
        print(fieldHalamanController.text);
      },
    );
  }

  TextFormField PenerbitField() {
    return TextFormField(
      controller: fieldPenerbitController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Penerbit Tidak Boleh Anopnymous";
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextFormField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Penerbit",
          label: Text("Penerbit")),
      onChanged: (value) {
        _formKey.currentState?.validate();

        if (value != null && value != "") {
          penerbit = value!;
        }
        setState(() {});
        print(fieldPenerbitController.text);
      },
    );
  }

  TextFormField ImageField() {
    return TextFormField(
      controller: fieldImageController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harap Masukan URL Gambar Yang Valid !";
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextFormField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Image Url",
          label: Text("Gambar Sampul")),
      onChanged: (value) {
        _formKey.currentState?.validate();

        if (value != null && value != "") {
          image = value;
        }
        setState(() {});
        print(fieldImageController.text);
      },
    );
  }

  TextFormField DisplayDateField(String value) {
    setState(() {
      fieldDateController.text = value.toString();
    });
    return TextFormField(
      controller: fieldDateController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal Wajib Diisi";
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          // Menambahkan border ke TextFormField
          borderRadius: BorderRadius.circular(8), // Mengatur sudut border
          borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
        ),
        prefix: Icon(Icons.calendar_today),
        labelText: "Waktu Terbit",
      ),
      onTap: () async {
        // _formKey.currentState?.validate();

        dateSelected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialEntryMode: DatePickerEntryMode.calendar,
        );
        if (dateSelected != null && dateSelected != "") {
          setState(() {
            fieldDateController.text =
                DateFormat('yyyy-MM-dd').format(dateSelected!);

            print("ini tanggal : " + fieldDateController.text);
          });
        }
      },
    );
  }
}
