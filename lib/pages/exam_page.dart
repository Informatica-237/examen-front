import 'dart:async';  // <- Importa para Timer
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'result_page.dart';
import '../models/question.dart';

class ExamPage extends StatefulWidget {
  final String nombre;
  final String dni;
  final String email;
  final String telefono;
  final String category;
  final List<Question> questions;

  const ExamPage({
    super.key,
    required this.nombre,
    required this.dni,
    required this.email,
    required this.telefono,
    required this.category,
    required this.questions,
  });

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int currentQuestionIndex = 0;
  List<int?> selectedAnswers = [];
  bool isSubmitting = false;

  static const int totalTimeInSeconds = 40 * 60; // 40 minutos
  late int timeLeftInSeconds;
  Timer? _timer;
  bool timeExpired = false;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<int?>.filled(widget.questions.length, null);
    timeLeftInSeconds = totalTimeInSeconds;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeftInSeconds > 0) {
        setState(() {
          timeLeftInSeconds--;
        });
      } else {
        setState(() {
          timeExpired = true;
        });
        timer.cancel();
        submitExam(forceFail: true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void nextQuestion() {
    if (selectedAnswers[currentQuestionIndex] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes seleccionar una opción antes de continuar')),
      );
      return;
    }

    bool isCorrect = selectedAnswers[currentQuestionIndex] == widget.questions[currentQuestionIndex].correctIndex;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? '¡Correcto!' : 'Incorrecto'),
        content: Text(isCorrect
            ? '¡Muy bien! Respuesta correcta.'
            : 'La respuesta correcta era: "${widget.questions[currentQuestionIndex].options[widget.questions[currentQuestionIndex].correctIndex]}"'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
              // Avanzar a siguiente pregunta o terminar
              if (currentQuestionIndex < widget.questions.length - 1) {
                setState(() => currentQuestionIndex++);
              } else {
                submitExam();
              }
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  Future<void> submitExam({bool forceFail = false}) async {
    _timer?.cancel();
    setState(() => isSubmitting = true);

    int correct = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedAnswers[i] == widget.questions[i].correctIndex) {
        correct++;
      }
    }

    // Si se agotó el tiempo, forzar desaprobación
    final bool approved = forceFail ? false : (correct >= (widget.questions.length * 0.7));
    final user = FirebaseAuth.instance.currentUser;

    try {
      await FirebaseFirestore.instance.collection('examenes').add({
        'uid': user?.uid,
        'nombre': widget.nombre,
        'dni': widget.dni,
        'email': widget.email,
        'telefono': widget.telefono,
        'categoria': widget.category,
        'correctas': correct,
        'total': widget.questions.length,
        'aprobado': approved,
        'fecha': Timestamp.now(),
        'tiempo_expirado': forceFail,
      });

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(
            approved: approved,
            message: approved
                ? '✅ ¡Aprobaste con $correct respuestas correctas!'
                : forceFail
                    ? '⏰ Tiempo agotado. No aprobaste.'
                    : '❌ No aprobaste. Tuviste $correct respuestas correctas.',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar resultados. Intentá de nuevo.')),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta ${currentQuestionIndex + 1} de ${widget.questions.length}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                formatTime(timeLeftInSeconds),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: isSubmitting
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.text,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Mostrar imagen si la pregunta tiene imagePath
                  if (question.imagePath != null) ...[
                    Center(
                      child: Image.asset(
                        question.imagePath!,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  ...List.generate(question.options.length, (index) {
                    return RadioListTile<int>(
                      title: Text(question.options[index]),
                      value: index,
                      groupValue: selectedAnswers[currentQuestionIndex],
                      onChanged: (value) {
                        setState(() {
                          selectedAnswers[currentQuestionIndex] = value!;
                        });
                      },
                    );
                  }),
                  const Spacer(),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: nextQuestion,
                      icon: Icon(currentQuestionIndex == widget.questions.length - 1
                          ? Icons.send
                          : Icons.arrow_forward),
                      label: Text(currentQuestionIndex == widget.questions.length - 1
                          ? 'Enviar'
                          : 'Siguiente'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
