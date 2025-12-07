import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class TargetPage extends StatelessWidget {
  final String email;
  TargetPage({required this.email});

  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Berhasil Login", style: TextStyle(fontSize: 24)),
            Text(email),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await auth.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false,
                );
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
