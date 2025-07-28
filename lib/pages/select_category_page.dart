import 'package:flutter/material.dart';
import 'exam_page.dart';
import '../models/question.dart';
import '../data/question_data.dart';

class SelectCategoryPage extends StatelessWidget {
  final String nombre;
  final String dni;
  final String email;
  final String telefono;

  const SelectCategoryPage({
    super.key,
    required this.nombre,
    required this.dni,
    required this.email,
    required this.telefono,
  });

  void _startExam(BuildContext context, String category) {
    final questions = questionBank[category];

    if (questions == null || questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Esta categoría no tiene preguntas.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExamPage(
          nombre: nombre,
          dni: dni,
          email: email,
          telefono: telefono,
          category: category,
          questions: questions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = questionBank.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccioná una categoría'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hola $nombre 👋',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('DNI: $dni'),
            Text('Email: $email'),
            Text('Teléfono: $telefono'),
            const SizedBox(height: 24),
            const Text('Elegí el tipo de examen que querés realizar:'),
            const SizedBox(height: 30),
            ...categories.map(
              (cat) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () => _startExam(context, cat),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(cat, style: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
