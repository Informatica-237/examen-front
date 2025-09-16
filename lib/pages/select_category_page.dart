// Archivo: lib/pages/select_category_page.dart

import 'package:flutter/material.dart';
import 'exam_page.dart';
import '../data/question_data.dart'; // Importa el archivo de datos

class SelectCategoryPage extends StatelessWidget {
  final String nombre;
  final String dni;
  final String email;
  final String telefono;
  final String edad;

  const SelectCategoryPage({
    Key? key,
    required this.nombre,
    required this.dni,
    required this.email,
    required this.telefono,
    required this.edad,
  }) : super(key: key);

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
    return WillPopScope(
      onWillPop: () async => false, // Bloquea el botón de retroceso
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2F2F2),
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 1),
                const Text(
                  'SELECCIONE CATEGORÍA',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7F94),
                  ),
                ),
                const SizedBox(height: 0.1),
                Container(height: 2, width: 210, color: const Color(0xFF2E7F94)),
                const SizedBox(height: 20),
                // Renderiza los botones de categoría con la nueva estructura
                ...categories.map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(category.imagePath, height: 100),
                        const SizedBox(height: 0),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () => _startExam(context, category.name),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7F94),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 7),
                            ),
                            // Aquí está el cambio clave: Usar un Column para el texto
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  category.name,
                                  style: const TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                if (category.description !=
                                    null) // Muestra el mini texto si existe
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      category.description!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Aquí se coloca la imagen de fondo, debajo de todos los botones
                const SizedBox(
                  height: 40,
                ), // Espacio entre el último botón y la imagen
                Image.asset(
                  'assets/icon/icono-muni/icon-muni.png',
                  fit: BoxFit.contain,
                  width: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
