import '../models/question.dart';

final List<Question> categoriaCEQuestions = [
  Question(
    text: '¿Qué tipo de licencia se requiere para conducir camiones con remolque?',
    options: [
      'Licencia A',
      'Licencia B',
      'Licencia C',
      'Licencia E',
    ],
    correctIndices: [3], // Se cambió a una lista de enteros
  ),
  // ... más preguntas
];