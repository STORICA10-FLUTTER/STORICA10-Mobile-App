import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storica_form_module/Testing/Mydrawer.dart';
import 'package:storica_form_module/Testing/home.dart';
import 'package:storica_form_module/Testing/list_item.dart';
import 'package:intl/intl.dart';
import 'package:storica_form_module/Testing/manually_created.dart';

class Item_Form extends StatefulWidget {
  const Item_Form({super.key});

  @override
  State<Item_Form> createState() => _Item_FormState();
}

class _Item_FormState extends State<Item_Form> {
  static DateTime? dateSelected;
  TextEditingController fieldController = TextEditingController();
  TextEditingController fieldDisplayDateController = TextEditingController();
  TextEditingController fieldPriceController = TextEditingController();
  TextEditingController fieldDescController = TextEditingController();
  TextEditingController fieldPenerbitController = TextEditingController();
  TextEditingController fieldDateController = TextEditingController();
  TextEditingController fieldImageController = TextEditingController();

  String judul = "";
  int jumlahHalaman = 0;
  String bahasa = "";
  String penerbit = "";
  String waktuTerbit = "";
  String image = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
                ), //https://i.pinimg.com/564x/75/e1/23/75e123edb9327e4d0ac1f1c648b4d239.jpg
              ),
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        fieldController.text,
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
                    onPressed: () {
                      ShowPopup();
                    },
                    child: Text("NEXT")),
              )
            ],
          )),
    ));
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
      controller: fieldController,
      decoration:
          InputDecoration(hintText: "Judul Buku", label: Text("Judul Buku")),
      onChanged: (value) {
        setState(() {});
        judul = value!;
        print("Nama Obat : $judul");
      },
    );
  }

  TextField BahasaField() {
    return TextField(
      controller: fieldDescController,
      decoration: InputDecoration(hintText: "Bahasa", label: Text("Bahasa")),
      onChanged: (value) {
        setState(() {});
        bahasa = value!;
        print("Deskrpsi : $bahasa");
      },
    );
  }

  TextField JumlahHalamanField() {
    int harga = 0;
    return TextField(
      controller: fieldPriceController,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          hintText: "Jumlah Halaman", label: Text("Jumlah Halaman")),
      onChanged: (hasil) {
        try {
          harga = int.parse(hasil);
          jumlahHalaman = harga;
        } catch (e) {
          print("Input yang anda masukan tidak Valid");
        }
        print("Ini adalah Haisl : $jumlahHalaman");
      },
    );
  }

  TextField PenerbitField() {
    return TextField(
      controller: fieldPenerbitController,
      decoration:
          InputDecoration(hintText: "Penerbit", label: Text("Penerbit")),
      onChanged: (value) {
        setState(() {});
        penerbit = value!;
        print("Deskrpsi : $penerbit");
      },
    );
  }

  TextField ImageField() {
    return TextField(
      controller: fieldImageController,
      decoration:
          InputDecoration(hintText: "Image Url", label: Text("Gambar Sampul")),
      onChanged: (value) {
        setState(() {});
        image = value!;
        print("Deskrpsi : $image");
      },
    );
  }

  TextField DisplayDateField(String value) {
    setState(() {
      fieldDateController.text = value.toString();
      print(fieldDisplayDateController.text);
      print(dateSelected);
    });
    return TextField(
      controller: fieldDateController,
      decoration: const InputDecoration(
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
                " " + DateFormat('dd-MM-yyyy').format(dateSelected!);
          });
        }
      },
    );
  }
}
