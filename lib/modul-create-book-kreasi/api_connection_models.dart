// ignore_for_file: prefer_const_constructors, empty_constructor_bodies

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostResult {
  String id = "";
  String name = "";
  String job = "";
  String created = "";

  PostResult(
      {required String id,
      required String name,
      required String job,
      required String created});
  factory PostResult.buatObject(Map<String, dynamic> obj) {
    // constructor
    return PostResult(
      id: obj['id'],
      name: obj['name'],
      job: obj['job'],
      created: obj['createdAt'],
    );
  }

  static Future<PostResult> connectAPI(String name, String job) async {
    // String APIurl = "https://reqres.in/api/users";
    String APIurl = 'https://randomuser.me/api/?results=100';
    var res =
        await http.post(Uri.parse(APIurl), body: {"name": name, "job": job});
    var jsonObj = json.decode(res.body);

    return PostResult.buatObject(jsonObj);
  }
}










// class APIConnection extends StatefulWidget {
//   const APIConnection({super.key});

//   @override
//   State<APIConnection> createState() => _APIConnectionState();
// }

// class _APIConnectionState extends State<APIConnection> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text("haloo"),
//         ),
//       ),
//     );
//   }
// }
