import 'package:flutter/material.dart';
import 'package:storica/home/screens/quotesku.dart';
import 'package:storica/home/screens/ubah_profil.dart';
import 'package:storica/home/widgets/clips.dart';
import 'package:storica/modul-create-book-kreasi/karyaku.dart';
import 'package:storica/variables.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:storica/login.dart';
import 'package:storica/home/widgets/full_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilePage> {
  Widget profil = const Icon(
    Icons.person,
    color: Color.fromARGB(255, 89, 89, 89),
    size: 120,
  );

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if (gambarurl != "") {
      profil = Image(image: NetworkImage(gambarurl), fit: BoxFit.fill);
    }
    double lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Halaman Profil',
          textAlign: TextAlign.left,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: custpath(),
              child: Container(
                width: lebar,
                color: const Color.fromARGB(255, 134, 104, 85),
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height:
                      375, // Increased height to make space for larger profile picture
                  child: Stack(
                    children: [
                      Positioned(
                        top: -100, // Lifted up by 50 pixels
                        left: -175,
                        child: Container(
                          width: 325,
                          height: 325,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(325),
                            color: const Color.fromARGB(25, 250, 250, 250),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        right: -200,
                        child: Container(
                          width: 325,
                          height: 325,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(325),
                            color: const Color.fromARGB(25, 250, 250, 250),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 375,
                          child: Center(
                            child: Column(children: [
                              const SizedBox(
                                height: 75,
                              ),
                              CircleAvatar(
                                  radius: 90,
                                  backgroundColor:
                                      const Color.fromARGB(255, 159, 159, 159),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: ClipOval(child: profil))),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        maintainState: false,
                                        builder: (context) =>
                                            const UbahProfil()),
                                  );
                                  setState(() {
                                    gambarurl = gambarurl;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      const Color.fromARGB(255, 134, 104, 85),
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 134, 104, 85),
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Ganti Foto Profil',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 134, 104, 85),
                                  ),
                                ),
                              ),
                            ]),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: lebar * 0.9,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your button press logic here
                    print("Draf saya");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 134, 104, 85),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 134, 104, 85), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Drafku',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 134, 104, 85),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: lebar * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Add your button press logic here
                  print("Buku Favorit");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 134, 104, 85),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 134, 104, 85), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Buku Favorit',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 134, 104, 85),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: lebar * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowKaryaku()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 134, 104, 85),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 134, 104, 85), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Karyaku',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 134, 104, 85),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: lebar * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuotesKuList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 134, 104, 85),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 134, 104, 85), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Quotesku',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 134, 104, 85),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: lebar * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final response = await request
                      .logout("http://localhost:8000/auth/logout/");
                  String message = response["message"];
                  if (response['status']) {
                    String uname = response["username"];
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("$message Sampai jumpa, $nama."),
                    ));
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("$message"),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 209, 37, 37),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 209, 37, 37), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Keluar',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 209, 37, 37),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
