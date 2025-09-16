// Archivo: lib/pages/main_menu.dart

import 'package:flutter/material.dart';
import 'input_data_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 250.0), // Espacio superior
          child: Column(
            // Alinea los elementos en la parte superior
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo más grande
              Image.asset('assets/icon/icono-muni/icon-muni.png', width: 250),
              const SizedBox(height: 130),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centra el contenido del Row
                children: [
                  const SizedBox(
                    width: 85,
                  ), // Añade un espacio a la izquierda para desplazar el texto a la derecha
                  Flexible(
                    child: const Text(
                      'EXAMEN LICENCIA DE CONDUCIR',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2E7F94),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InputDataPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFFF2F2F2,
                  ), // <-- Color de fondo
                  foregroundColor: const Color(
                    0xFF2E7F94,
                  ), // <-- Color de la letra
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  side: const BorderSide(
                    color: Color(0xFF2E7F94), // <-- Color del borde
                    width: 2.0, // Ancho del borde
                  ),
                  elevation: 5, // <-- Nivel de la sombra
                  shadowColor: Colors.grey, // <-- Color de la sombra
                ),
                child: const Text('Ingresar', style: TextStyle(fontSize: 18)),
              ),
              const Spacer(), // <-- Este widget empuja los elementos a los extremos
              Image.asset(
                'assets/icon/icono-muni/base.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
