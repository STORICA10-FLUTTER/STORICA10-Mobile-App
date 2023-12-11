import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ReadPdf extends StatefulWidget {
  const ReadPdf({super.key});

  @override
  State<ReadPdf> createState() => _ReadPdfState();
}

class _ReadPdfState extends State<ReadPdf> {
  static String textresult = "None";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Text("SELAMAT DATANG"),
                Text(textresult),
                ElevatedButton(
                    onPressed: () async {
                      String response;
                      response = await rootBundle.loadString('a.txt');
                      setState(() {
                        textresult = response;
                        print(textresult);
                      });
                    },
                    child: Text("Read Pdf")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
