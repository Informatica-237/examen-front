import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart'; // generado por FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dniController = TextEditingController();

  String resultMessage = '';
  bool examStarted = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _signInAnonymously();
  }

  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      // Manejar error si se quiere
      debugPrint('Error en login anónimo: $e');
    }
  }

  void startExam() {
    if (nameController.text.isEmpty || dniController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completá tu nombre y DNI')),
      );
      return;
    }
    setState(() {
      examStarted = true;
      resultMessage = '';
      selectedAnswers.clear();
    });
  }

  Future<void> submitExam() async {
    if (selectedAnswers.length < questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, respondé todas las preguntas')),
      );
      return;
    }

    setState(() => isLoading = true);

    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctIndex) {
        correct++;
      }
    }

    final bool approved = correct >= (questions.length * 0.7);
    final user = FirebaseAuth.instance.currentUser;

    try {
      await FirebaseFirestore.instance.collection('examenes').add({
        'uid': user?.uid,
        'nombre': nameController.text.trim(),
        'dni': dniController.text.trim(),
        'correctas': correct,
        'aprobado': approved,
        'fecha': Timestamp.now(),
      });

      setState(() {
        resultMessage = approved
            ? '✅ ¡Felicitaciones! Aprobaste con $correct respuestas correctas.'
            : '❌ Lo siento. Solo respondiste $correct bien. No aprobaste.';
        examStarted = false;
        nameController.clear();
        dniController.clear();
        selectedAnswers.clear();
      });

      // Cerrar sesión anónima para "resetear" usuario y permitir otro examen
      await FirebaseAuth.instance.signOut();
      await _signInAnonymously();

    } catch (e) {
      setState(() {
        resultMessage = 'Error al enviar datos. Intentá nuevamente.';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : (examStarted ? buildExamView() : buildStartForm()),
      ),
    );
  }

  Widget buildStartForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Por favor, ingresá tus datos para comenzar:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Nombre y Apellido',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: dniController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'DNI',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton.icon(
            onPressed: startExam,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Comenzar Examen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildExamView() {
    return ListView.builder(
      itemCount: questions.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              '👋 Hola ${nameController.text}, comenzá tu examen.',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        } else if (index <= questions.length) {
          final question = questions[index - 1];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pregunta $index: ${question.text}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  for (int i = 0; i < question.options.length; i++)
                    RadioListTile<int>(
                      title: Text(question.options[i]),
                      value: i,
                      groupValue: selectedAnswers[index - 1],
                      onChanged: (value) {
                        setState(() {
                          selectedAnswers[index - 1] = value!;
                        });
                      },
                    ),
                ],
              ),
            ),
          );
        } else {
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
    );
  }
}
