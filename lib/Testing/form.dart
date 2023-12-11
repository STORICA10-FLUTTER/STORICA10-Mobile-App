import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storica_form_module/Testing/Mydrawer.dart';
import 'package:storica_form_module/Testing/home.dart';
import 'package:storica_form_module/Testing/list_item.dart';
import 'package:intl/intl.dart';
import 'package:storica_form_module/Testing/manually_created.dart';
import 'package:storica_form_module/Testing/providers/models.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';

class Item_Form extends StatefulWidget {
  const Item_Form({super.key});

  @override
  State<Item_Form> createState() => _Item_FormState();
}

class _Item_FormState extends State<Item_Form> {
  static DateTime? dateSelected;
  TextEditingController fieldDisplayDateController = TextEditingController();
  TextEditingController fieldHalamanController = TextEditingController();
  TextEditingController fieldBahasaController = TextEditingController();
  TextEditingController fieldPenerbitController = TextEditingController();
  TextEditingController fieldDateController = TextEditingController();
  TextEditingController fieldImageController = TextEditingController();
  TextEditingController fieldJudulController = TextEditingController();

  String judul = "";
  int jumlahHalaman = 0;
  String bahasa = "";
  String penerbit = "";
  String waktuTerbit = "";
  String image = "";
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // var judulProvider = Provider.of<BukuProvider>(context, listen: true).judul;
    // final jumlahHalamanProvider =
    //     Provider.of<BukuProvider>(context, listen: true).jumlahHalaman;
    // final bahasaProvider =
    //     Provider.of<BukuProvider>(context, listen: true).bahasa;
    // var penerbitProvider =
    //     Provider.of<BukuProvider>(context, listen: true).penerbit;
    // final waktuTerbitProvider =
    //     Provider.of<BukuProvider>(context, listen: true).waktuTerbit;
    // final imageProvider =
    //     Provider.of<BukuProvider>(context, listen: true).image;

    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Form Daftar Item"),
        ),
        drawer: MyDrawer(),
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
                Column(
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
                              child: DisplayDateField(fieldDateController.text),
                            ),
                          ],
                        )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Home();
                        }));
                      },
                      child: Text("BACK")),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextButton(
                      onPressed: () async {
                        ShowPopup();
                        // postData(
                        //     Provider.of<BukuProvider>(context, listen: false)
                        //         .judul);

                        var uri = ("http://127.0.0.1:8000/post-buku-kreasi");
                        // var response = await http.post(Uri.parse(uri), body: {
                        //   "judul":
                        //       Provider.of<BukuProvider>(context, listen: false)
                        //           .judul,
                        //   'penerbit':
                        //       Provider.of<BukuProvider>(context, listen: false)
                        //           .penerbit,
                        //   'jumlah_halaman':
                        //       Provider.of<BukuProvider>(context, listen: false)
                        //           .jumlahHalaman
                        //           .toString(),
                        //   'bahasa':
                        //       Provider.of<BukuProvider>(context, listen: false)
                        //           .bahasa,
                        //   'tanggal_terbit':
                        //       Provider.of<BukuProvider>(context, listen: false)
                        //           .waktuTerbit,
                        //   'gambar':
                        //       Provider.of<BukuProvider>(context, listen: false)
                        //           .image
                        // });
                        // fieldDisplayDateController.clear();
                        // fieldPenerbitController.clear();
                        // fieldHalamanController.clear();
                        // fieldBahasaController.clear();
                        // fieldDateController.clear();
                        // fieldImageController.clear();
                        // fieldController.clear();
                        // judulProvider = "";
                        // penerbit = "";

                        print("apakah berhasil");

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // methode list item
                      Container(
                        height: 200,
                        width: 200,
                        margin: EdgeInsets.fromLTRB(30, 0, 20, 0),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(30, 30)),
                            onPressed: () {},
                            icon: Icon(Icons.picture_as_pdf_rounded),
                            label: Text("Browse Pdf")),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 30, 0),
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
                )),
          ));

  TextField JudulField() {
    return TextField(
      controller: fieldJudulController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Judul Buku",
          label: Text("Judul Buku")),
      onChanged: (value) {
        setState(() {});

        print(fieldJudulController.text);
      },
    );
  }

  TextField BahasaField() {
    return TextField(
      controller: fieldBahasaController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Bahasa",
          label: Text("Bahasa")),
      onChanged: (value) {
        ;
        setState(() {});
        bahasa = value!;
        print("Deskrpsi : $bahasa");
      },
    );
  }

  TextField JumlahHalamanField() {
    int jmlhal = 0;
    return TextField(
      controller: fieldHalamanController,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Jumlah Halaman",
          label: Text("Jumlah Halaman")),
      onChanged: (hasil) {
        try {
          jmlhal = int.parse(hasil);
          jumlahHalaman = jmlhal;
        } catch (e) {
          print("Input yang anda masukan tidak Valid");
        }
        print(fieldHalamanController.text);
      },
    );
  }

  TextField PenerbitField() {
    return TextField(
      controller: fieldPenerbitController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Penerbit",
          label: Text("Penerbit")),
      onChanged: (value) {
        setState(() {});
        penerbit = value!;
        print(fieldPenerbitController.text);
      },
    );
  }

  TextField ImageField() {
    return TextField(
      controller: fieldImageController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // Menambahkan border ke TextField
            borderRadius: BorderRadius.circular(8), // Mengatur sudut border
            borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
          ),
          hintText: "Image Url",
          label: Text("Gambar Sampul")),
      onChanged: (value) {
        setState(() {});
        image = value!;
        print(fieldImageController.text);
      },
    );
  }

  TextField DisplayDateField(String value) {
    setState(() {
      fieldDateController.text = value.toString();
    });
    return TextField(
      controller: fieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          // Menambahkan border ke TextField
          borderRadius: BorderRadius.circular(8), // Mengatur sudut border
          borderSide: BorderSide(color: Colors.grey), // Mengatur warna border
        ),
        prefix: Icon(Icons.calendar_today),
        labelText: "Waktu Terbit",
      ),
      onTap: () async {
        dateSelected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialEntryMode: DatePickerEntryMode.calendar,
        );
        if (dateSelected != null) {
          setState(() {
            fieldDateController.text =
                DateFormat('yyyy-MM-dd').format(dateSelected!);

            print("ini tanggal : " + fieldDateController.text);
          });
        }
      },
    );
  }

  // void postData(String nama) async {
  //   // bakal update
  //   nama = "rakha";
  //   var uri = Uri.parse("http://127.0.0.1:8000/json/");
  // var response =
  //     await http.post(uri, body: {"title": "1", "body": nama, "userId": "1"});
  //   // var data = json.decode(response.body);
  //   // result = data;
  //   setState(() {});
  //   // print(result);
  //   print(response.body);
  //   // print(data);
  // }
}
