// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostHome extends StatefulWidget {
  const PostHome({super.key});

  @override
  State<PostHome> createState() => _PostHomeState();
}

class _PostHomeState extends State<PostHome> {
  TextEditingController fieldController = TextEditingController();
  static String name = "";

  static Map<String, dynamic> result = {};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: fieldController,
                onChanged: (value) {
                  setState(() {});
                  name = value!;
                  print("Nama Obat : $name");
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      postData(name);
                    });
                  },
                  child: Text("Post Data")),
              Center(
                child: Container(
                    child: Text(
                        (result.isEmpty) ? "None" : result["name"].toString())),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      getData();
                    });
                  },
                  child: Text("Get Posted Data")),
              Center(
                child: Container(
                    child: Text(
                        (result.isEmpty) ? "None" : result["body"].toString())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void postData(String nama) async {
    // bakal update
    nama = "rakha";
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response =
        await http.post(uri, body: {"title": "1", "body": nama, "userId": "1"});
    var data = json.decode(response.body);
    result = data;
    setState(() {});
    // print(result);
    print(response.body);
    // print(data);
  }

  void getData() async {
    //cuma dapetin data doang ga update
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.get(uri);
    var data = json.decode(response.body);
    setState(() {
      result = data;
    });
    print(result);
    print(response.body);
    print(data);
  }
}
