import 'package:flutter/material.dart';
import 'package:storica/home/widgets/clips.dart';
import 'package:storica/home/widgets/quotes.dart';
import 'package:storica/home/widgets/search_bar.dart';
import 'package:storica/home/widgets/sampul_besar.dart';
import 'package:storica/home/widgets/buku_kreasi.dart';
import 'package:storica/home/widgets/buku_semua.dart';
import 'package:storica/home/widgets/buku_inggris.dart';
import 'package:storica/home/widgets/buku_toprated.dart';
import 'package:storica/variables.dart';
import 'package:storica/functions/bold_substring.dart';
import 'package:storica/home/screens/write.dart';
import 'package:storica/home/screens/profile_page.dart';
import 'package:storica/home/widgets/full_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: const Color.fromARGB(255, 134, 104, 85),
          backgroundColor: Colors.white,
          elevation: 0,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home_outlined, color: Colors.white),
              icon: Icon(Icons.home_outlined),
              label: 'Utama',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.create_outlined,
                color: Colors.white,
              ),
              icon: Icon(Icons.create_outlined),
              label: 'Tulis',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.bookmark_outline_outlined,
                color: Colors.white,
              ),
              icon: Icon(Icons.bookmark_outline_outlined),
              label: 'Favorit',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
              ),
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profil',
            ),
          ],
        ),
      ),
      body: <Widget>[
        Scaffold(
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              ClipPath(
                clipper: custpath(),
                child: Container(
                  width: lebar,
                  color: const Color.fromARGB(255, 134, 104, 85),
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    height: 530,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -150,
                          left: -250,
                          child: Container(
                            width: 475,
                            height: 475,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(475),
                              color: const Color.fromARGB(25, 250, 250, 250),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          right: -300,
                          child: Container(
                            width: 450,
                            height: 450,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(450),
                              color: const Color.fromARGB(25, 250, 250, 250),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  width: lebar,
                                  child: const CustomSearchBar(),
                                )),
                            const Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Sedang Tren",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: BukuTrend(),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  "Hi $nama,\nselamat membaca!",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ).boldSubString(
                                    'username',
                                    const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 20)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const QuotesList(),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: lebar * 0.9,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Align items at the ends
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Karya Pengguna',
                        style: TextStyle(
                          color: Color.fromARGB(255, 50, 45, 45),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewBuku(
                                listparr: "Karya Pengguna",
                              ),
                            ));
                      },
                      color: const Color.fromARGB(255, 50, 45, 45),
                    ),
                  ],
                ),
              ),
              const BukuKreasiList(),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: lebar * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Buku Berbahasa Inggris',
                        style: TextStyle(
                          color: Color.fromARGB(255, 50, 45, 45),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewBuku(
                                listparr: "Buku Berbahasa Inggris",
                              ),
                            ));
                      },
                      color: const Color.fromARGB(255, 50, 45, 45),
                    ),
                  ],
                ),
              ),
              const BukuInggris(),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: lebar * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Buku Rating Tertinggi',
                        style: TextStyle(
                          color: Color.fromARGB(255, 50, 45, 45),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewBuku(
                                listparr: "Buku Rating Tertinggi",
                              ),
                            ));
                      },
                      color: const Color.fromARGB(255, 50, 45, 45),
                    ),
                  ],
                ),
              ),
              const BukuRated(),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: lebar * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Koleksi Kami',
                        style: TextStyle(
                          color: Color.fromARGB(255, 50, 45, 45),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewBuku(
                                listparr: "Koleksi Kami",
                              ),
                            ));
                      },
                      color: const Color.fromARGB(255, 50, 45, 45),
                    ),
                  ],
                ),
              ),
              const BukuSemua(),
            ],
          )),
        ),
        Card(
          color: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(0),
          child: SizedBox(
            child: Make(),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Buku Favorit',
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
        ),
        const ProfilePage(),
      ][currentPageIndex],
    );
  }
}
