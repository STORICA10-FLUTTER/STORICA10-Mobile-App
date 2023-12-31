import 'package:storica/home/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:storica/variables.dart';
import 'package:storica/register.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masuk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;

    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masuk'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12.0),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text("Belum punya akun?"),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistPage()));
                  },
                  child: Text(
                    "Registrasi",
                    style: TextStyle(color: Colors.indigo[900]),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 24.0),
            SizedBox(
              width: lebar * 0.94,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 134, 104, 85)),
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  // Cek kredensial
                  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                  // Untuk menyambungkan Android emulator dengan Django pada localhost,
                  // gunakan URL http://10.0.2.2/
                  final response = await request
                      .login("https://storica.up.railway.app/auth/login/", {
                    'username': username,
                    'password': password,
                  });

                  if (request.loggedIn) {
                    String message = response['message'];
                    String uname = response['username'];
                    nama = uname;
                    gambarurl = response['gambar'];
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text("$message Selamat datang, $uname.")));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'Gagal Masuk',
                          style: TextStyle(
                              color: Color.fromARGB(255, 134, 104, 85)),
                        ),
                        content: Text(response['message'],
                            style: TextStyle(
                                color: Color.fromARGB(255, 134, 104, 85))),
                        actions: [
                          TextButton(
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 134, 104, 85)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text(
                  'Masuk',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
