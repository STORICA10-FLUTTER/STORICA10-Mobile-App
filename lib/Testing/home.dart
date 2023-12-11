import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storica_form_module/Testing/Mydrawer.dart';
import 'package:storica_form_module/Testing/api_connection_models.dart';
import 'package:storica_form_module/Testing/form.dart';
import 'package:storica_form_module/Testing/list_item.dart';
import 'package:storica_form_module/Testing/post.dart';
import 'package:storica_form_module/Testing/post_home.dart';
import 'package:storica_form_module/Testing/providers/models.dart';
import 'package:storica_form_module/Testing/readPDF.dart';
import 'package:storica_form_module/Testing/show_with_API.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("STORICA"),
        ),
        drawer: MyDrawer(),
        body: Center(
          child: SizedBox(
            // ignore: sort_child_properties_last
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Halo ini didalam container',
                    style: TextStyle(color: Colors.amber),
                  ),
                  Container(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const List_Item();
                          }));
                        },
                        child: Text("Show Item")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Item_Form();
                        }));
                      },
                      child: Text("Daftarkan Item"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Show_API();
                          }),
                        );
                      },
                      child: Text("GET API Page"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const PostHome();
                          }),
                        );
                      },
                      child: Text("POST API Page"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ReadPdf();
                          }),
                        );
                      },
                      child: Text("Read PDF"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return PostJson();
                          }),
                        );
                      },
                      child: Text("TEST POST SOMETHING"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// sama aja kyk : void main() => runApp(Home());
