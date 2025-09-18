import 'dart:async';
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
  List<Set<int>?> selectedAnswers = []; // CAMBIO: Usamos un Set para múltiples selecciones
  bool isSubmitting = false;

  static const int totalTimeInSeconds = 45 * 60; // 40 minutos
  late int timeLeftInSeconds;
  Timer? _timer;
  bool timeExpired = false;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<Set<int>?>.filled(widget.questions.length, null);
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
    final selectedSet = selectedAnswers[currentQuestionIndex];
    if (selectedSet == null || selectedSet.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes seleccionar al menos una opción antes de continuar'),
        ),
      );
      return;
    }

    final correctSet = widget.questions[currentQuestionIndex].correctIndices.toSet();

    bool isCorrect = selectedSet.length == correctSet.length && selectedSet.containsAll(correctSet);
    
    // CAMBIO: Mensaje para mostrar las opciones correctas en caso de error.
    String correctAnswersText = correctSet.map((index) => widget.questions[currentQuestionIndex].options[index]).join(', ');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? '¡Correcto!' : 'Incorrecto'),
        content: Text(
          isCorrect
              ? '¡Muy bien! Respuesta correcta.'
              : 'La respuesta(s) correcta(s) era(n): "$correctAnswersText"',
        ),
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
      final selectedSet = selectedAnswers[i]?.toSet() ?? {};
      final correctSet = widget.questions[i].correctIndices.toSet();

      if (selectedSet.length == correctSet.length && selectedSet.containsAll(correctSet)) {
        correct++;
      }
    }

    // Si se agotó el tiempo, forzar desaprobación
    final bool approved = forceFail
        ? false
        : (correct >= (widget.questions.length * 0.7));
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
        const SnackBar(
          content: Text('Error al enviar resultados. Intentá de nuevo.'),
        ),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return WillPopScope(
      onWillPop: () async => false, // Bloquea el botón de retroceso
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pregunta ${currentQuestionIndex + 1} de ${widget.questions.length}',
          ),
          backgroundColor: const Color(0xFFF2F2F2),
          foregroundColor: const Color(0xFF2E7F94),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  formatTime(timeLeftInSeconds),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: isSubmitting
            ? const Center(child: CircularProgressIndicator())
            : Container(
                color: const Color(0xFFF2F2F2),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.text,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
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
                        final selectedSet = selectedAnswers[currentQuestionIndex];
                        return CheckboxListTile( // CAMBIO: Usamos CheckboxListTile
                          title: Text(question.options[index]),
                          value: selectedSet != null && selectedSet.contains(index),
                          onChanged: (bool? value) {
                            setState(() {
                              if (selectedAnswers[currentQuestionIndex] == null) {
                                selectedAnswers[currentQuestionIndex] = {};
                              }
                              if (value == true) {
                                selectedAnswers[currentQuestionIndex]!.add(index);
                              } else {
                                selectedAnswers[currentQuestionIndex]!.remove(index);
                              }
                            });
                          },
                        );
                      }),
                      const Spacer(),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: nextQuestion,
                          icon: Icon(
                            currentQuestionIndex == widget.questions.length - 1
                                ? Icons.send
                                : Icons.arrow_forward,
                          ),
                          label: Text(
                            currentQuestionIndex == widget.questions.length - 1
                                ? 'Enviar'
                                : 'Siguiente',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}