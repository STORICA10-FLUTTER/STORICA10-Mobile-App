import 'package:flutter/material.dart';

class List_Item extends StatefulWidget {
  const List_Item({super.key});

  @override
  ShowItem createState() => ShowItem();
}

class ShowItem extends State<List_Item> {
  List<String> items = ["a", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  // ShowItem() {
  //   for (int i = 0; i < items.length; i++) {
  //     items.add((Text("Item ke - $i")));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Show Item"),
        ),
        body: Center(
          child: Column(
            children: [
              ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => Container(
                  child: Text(items[index].toString()),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Bcak"))
            ],
          ),
        ),
        // body: Container(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Center(
        //             child: ElevatedButton(
        //                 onPressed: () {
        //                   Navigator.pop(context);
        //                 },
        //                 child: const Text("BACK")),
        //           )
        //         ],
        //       ),
        //       Container(
        //         child: ListView(
        //           children: <Widget>[
        //             Container(
        //               child: Text("hai lagi ini list view"),
        //             )
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
