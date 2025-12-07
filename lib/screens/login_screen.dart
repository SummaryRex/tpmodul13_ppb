import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
import 'target_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final auth = AuthService();

  void handleLogin() async {
    if (emailC.text.isEmpty || passC.text.isEmpty) {
      showMessage("Field tidak boleh kosong");
      return;
    }

    final user = await auth.login(emailC.text, passC.text);

    if (user == null) {
      showMessage("Login Gagal");
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            TargetPage(email: FirebaseAuth.instance.currentUser?.email ?? ''),
      ),
    );
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome Back", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            TextField(
              controller: emailC,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passC,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: handleLogin, child: Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterPage()),
                );
              },
              child: Text("Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}
