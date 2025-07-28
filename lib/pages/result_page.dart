import 'package:flutter/material.dart';
import 'input_data_page.dart'; // Importar para limpiar los controladores

class ResultPage extends StatelessWidget {
  final bool approved;
  final String message;

  const ResultPage({
    super.key,
    required this.approved,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado del Examen'),
        backgroundColor: approved ? Colors.green : Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: approved ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text('Inicio'),
                onPressed: () {
                  // Limpiar los campos antes de volver al inicio
                  InputDataPage.clearControllers();

                  // Volver al inicio
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
