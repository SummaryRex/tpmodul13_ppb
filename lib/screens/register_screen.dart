import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'target_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final auth = AuthService();

  void handleRegister() async {
    if (emailC.text.isEmpty || passC.text.isEmpty) {
      showMessage("Field tidak boleh kosong");
      return;
    }

    final user = await auth.register(emailC.text, passC.text);

    if (user == null) {
      showMessage("Register Gagal");
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => TargetPage(email: user.email ?? '')),
    );
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            TextField(controller: emailC, decoration: InputDecoration(labelText: "Email")),
            TextField(
              controller: passC,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleRegister,
              child: Text("Register"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Kembali ke Login"),
            ),
          ],
        ),
      ),
    );
  }
}
