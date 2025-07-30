import 'package:flutter/material.dart';
import 'admin_result_view.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  String errorMessage = '';

  void _login() {
    const String hardcodedUser = 'admin';
    const String hardcodedPass = 'admin123';

    if (userController.text == hardcodedUser &&
        passController.text == hardcodedPass) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminResultView()),
      );
    } else {
      setState(() {
        errorMessage = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: userController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Ingresar'),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
