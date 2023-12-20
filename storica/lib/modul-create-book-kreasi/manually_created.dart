import 'package:flutter/material.dart';
import 'package:storica/home/screens/menu.dart';
import 'package:storica/modul-create-book-kreasi/form.dart';

class ManualCreate extends StatefulWidget {
  const ManualCreate({super.key});

  @override
  State<ManualCreate> createState() => _ManualCreateState();
}

class _ManualCreateState extends State<ManualCreate> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  TextEditingController _textEditingController = TextEditingController();
  String tempResult = "";
  String finalResult = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
          child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                "TULIS BUKU",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: TextFormField(
                  controller: _textEditingController,
                  onChanged: (value) {
                    setState(() {
                      _textEditingController.text = value;
                      print(_textEditingController.text);
                    });
                  },
                  minLines: 10,
                  maxLines: 20,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: "Silakan Tulis Cerita Untuk Buku Anda...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Item_Form();
                }));
              },
              child: Text("BACK")),
          TextButton(
              onPressed: () {
                final custom_snackBar = SnackBar(
                  content: const Text('Successfully Saved Changed'),
                  action: SnackBarAction(
                    label: 'Home',
                    onPressed: () {
                      fetchNotes();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return MyHomePage();
                        }),
                      );
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(custom_snackBar);

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
              },
              child: Text("Save Changes")),
          TextButton(
              onPressed: () {
                showConfirmationPublish();
              },
              child: Text("PUBLISH")),
        ],
      )),
    );
  }

  void showConfirmationSave() {}

  void showConfirmationPublish() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 14, 53, 72),
            title: Center(
                child: Text(
              "Are You Sure To Publish ?",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            content: Container(
                height: 300,
                width: 800,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 30, 0),
                          height: 200,
                          width: 200,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(30, 30)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.edit),
                              label: Text("No, Continue Editing")),
                        ),
                        // methode list item
                        Container(
                          height: 200,
                          width: 200,
                          margin: EdgeInsets.fromLTRB(30, 0, 20, 0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(30, 30)),
                              onPressed: () {
                                // hqarusnya nampilin snackbar dulu bahwa berhasil di pulblihs
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MyHomePage();
                                }));
                              },
                              icon: Icon(Icons.picture_as_pdf_rounded),
                              label: Text("Yes")),
                        ),
                      ],
                    ),
                  ),
                )),
          ));

  Future fetchNotes() async {
    var url = "";
  }
}
