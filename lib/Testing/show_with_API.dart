import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:storica_form_module/Testing/Mydrawer.dart';
import 'package:storica_form_module/Testing/api_connection_models.dart';
import 'package:http/http.dart' as http;

class Show_API extends StatefulWidget {
  Show_API({super.key});

  @override
  State<Show_API> createState() => _Show_APIState();
}

class _Show_APIState extends State<Show_API> {
  List<dynamic> users = [];
  PostResult? result = null;

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    var namaPanjang = users[0]; // ntni di loop indexnya
    return MaterialApp(
      home: Scaffold(
        drawer: MyDrawer(),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                width: 100,
                height: 40,
                child: InkWell(
                  splashColor: Colors.red[200],
                  focusColor: Colors.yellow,
                  highlightColor: Colors.red[200],
                  onTap: () {},
                  child: Text("Nama Panjang : " +
                      namaPanjang["name"]["first"].toString() +
                      " " +
                      namaPanjang["name"]["last"].toString()),
                ),
              )),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      fetchUser();
                      setState(() {
                        print(users.toString());
                      });

                      print("ini dia a: \n");
                    },
                    child: Text("POST Something")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchUser() async {
    const url = 'https://randomuser.me/api/?results=10';
    //                                    result=length
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    // print(response.body);
    final json = jsonDecode(response.body);
    // print(json["result"]);
    // print("Last Name : " + json["results"][10]["name"]["last"]);
    // print("\n ");
    setState(() {
      users = json["results"];
      // print("ini jason pertama :: $users[0]");
      // print(user);
    });
  }
}
