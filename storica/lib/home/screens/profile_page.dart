import 'package:flutter/material.dart';
import 'package:storica/home/widgets/clips.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Storica',
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
        body: Column(children: [
          ClipPath(
              clipper: custpath(),
              child: Container(
                  width: lebar,
                  color: const Color.fromARGB(255, 134, 104, 85),
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                      height: 325,
                      child: Stack(children: [
                        Positioned(
                          top: -150,
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
                      ])))),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
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
                // Add your button press logic here
                print("Karyaku");
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
                // Add your button press logic here
                print("Quotesku");
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
              onPressed: () {
                // Add your button press logic here
                print("Keluar");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 134, 104, 85),
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
        ]));
  }
}
