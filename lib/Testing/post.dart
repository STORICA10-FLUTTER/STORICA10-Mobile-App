import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PostJson extends StatefulWidget {
  const PostJson({super.key});

  @override
  State<PostJson> createState() => _PostJsonState();
}

class _PostJsonState extends State<PostJson> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Repository {
  final _baseUrl = "https://6568d6699927836bd9757e4d.mockapi.io/User";
}
