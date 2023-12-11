import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:storica_form_module/Testing/login_page.dart';
import 'package:storica_form_module/Testing/providers/models.dart';

void main() {
  runApp(MyApp());

  //methode runapp ==> jalanin app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();
          return request;
        },
        child: MaterialApp(home: Login_Page()));
  }
}
// sama aja kyk : void main() => runApp(myApp());
