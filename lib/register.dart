import 'package:storica/home/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:storica/variables.dart';
import 'package:storica/login.dart';

void main() {
  runApp(const RegistApp());
}

class RegistApp extends StatelessWidget {
  const RegistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registrasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegistPage(),
    );
  }
}

class RegistPage extends StatefulWidget {
  const RegistPage({super.key});

  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;

    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
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
            TextField(
              controller: _confirmController,
              decoration: const InputDecoration(
                labelText: 'Konfirmasi password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12.0),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text("Sudah punya akun?"),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Masuk",
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
                  String confirm = _confirmController.text;

                  // Cek kredensial
                  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                  // Untuk menyambungkan Android emulator dengan Django pada localhost,
                  // gunakan URL http://10.0.2.2/
                  final response = await request.post(
                      "https://storica.up.railway.app/auth/register/", {
                    'username': username,
                    'password': password,
                    'confirm': confirm
                  });

                  if (response['status'] == 'success') {
                    String uname = response['username'];
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text(
                              "Selamat bergabung, $uname! Akunmu sudah terdaftar")));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'Gagal Terdaftar',
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
                  'Daftar',
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
