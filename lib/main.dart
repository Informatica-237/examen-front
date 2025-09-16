// Archivo: lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/main_menu.dart'; // <-- ¡Nueva importación!
import 'pages/input_data_page.dart';
import 'pages/admin_login_page.dart';
import 'pages/admin_result_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0099FF)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenuPage(), // <-- ¡Nueva ruta inicial!
        '/input-data': (context) => const InputDataPage(),
        '/login': (context) => const AdminLoginPage(),
        '/admin': (context) => const AdminResultView(),
      },
    );
  }
}