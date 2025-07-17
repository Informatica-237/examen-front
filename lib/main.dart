import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 153, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Examen de Prueba'),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Question> questions = [
    Question(
      text: '¿Cuál es la capital de Argentina?',
      options: ['Córdoba', 'Buenos Aires', 'Rosario', 'Mendoza'],
      correctIndex: 1,
    ),
    Question(
      text: '¿Qué lenguaje se usa en Flutter?',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctIndex: 2,
    ),
    Question(
      text: '¿Cuántos días tiene una semana?',
      options: ['5', '6', '7'],
      correctIndex: 2,
    ),
  ];

  final Map<int, int> selectedAnswers = {};

  String resultMessage = '';

  void submitExam() {
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctIndex) {
        correct++;
      }
    }

    final bool approved = correct >= (questions.length * 0.7); // 70% para aprobar
    setState(() {
      resultMessage = approved
          ? '✅ ¡Felicitaciones! Aprobaste con $correct respuestas correctas.'
          : '❌ Lo siento. Solo respondiste $correct bien. No aprobaste.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {
          if (index < questions.length) {
            final question = questions[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pregunta ${index + 1}: ${question.text}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    for (int i = 0; i < question.options.length; i++)
                      RadioListTile<int>(
                        title: Text(question.options[i]),
                        value: i,
                        groupValue: selectedAnswers[index],
                        onChanged: (value) {
                          setState(() {
                            selectedAnswers[index] = value!;
                          });
                        },
                      ),
                  ],
                ),
              ),
            );
          } else {
            // Botón de enviar y resultado
            return Column(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  onPressed: submitExam,
                  label: const Text('Enviar respuestas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
                const SizedBox(height: 20),
                if (resultMessage.isNotEmpty)
                  Text(
                    resultMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: resultMessage.contains('✅') ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
