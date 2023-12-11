import 'package:flutter/material.dart';
import 'package:storica_form_module/Testing/form.dart';
import 'package:storica_form_module/Testing/home.dart';
import 'package:storica_form_module/Testing/manually_created.dart';
import 'package:storica_form_module/Testing/post_home.dart';
import 'package:storica_form_module/Testing/show_with_API.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Contoh Drawer')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(
                  child: Container(
                    child: Text(
                      'STORICA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('Home'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Home();
                    }),
                  );
                  // Aksi yang ingin dilakukan saat Item 1 dipilih
                  // Misalnya, navigasi ke halaman tertentu
                },
              ),
              ListTile(
                title: Text('Pendafaftar Buku'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Item_Form();
                    }),
                  );
                  // Aksi yang ingin dilakukan saat Item 2 dipilih
                },
              ),
              ListTile(
                title: Text('GET API'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Show_API();
                    }),
                  );
                  // Aksi yang ingin dilakukan saat Item 2 dipilih
                },
              ),
              ListTile(
                title: Text('POST API'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return PostHome();
                    }),
                  );
                  // Aksi yang ingin dilakukan saat Item 2 dipilih
                },
              ),
              // Tambahkan ListTile lain jika dibutuhkan
            ],
          ),
        ),
        body: Center(
          child: Text('Isi Halaman Utama'),
        ),
      ),
    );
    ;
  }
}
