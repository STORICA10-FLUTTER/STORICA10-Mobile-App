import 'package:flutter/material.dart';

class ShowUserItem extends StatefulWidget {
  final products;

  const ShowUserItem({super.key, this.products});

  @override
  State<ShowUserItem> createState() => _ShowUserItemState();
}

class _ShowUserItemState extends State<ShowUserItem> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("User Item"),
        ),
        body: Container(
          child: Column(
            children: [
              TextButton(onPressed: () {}, child: Text(widget.products))
            ],
          ),
        ),
      ),
    );
  }
}
