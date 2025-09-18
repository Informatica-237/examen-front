import '../models/question.dart';

final List<Question> categoriaBQuestions = [
  Question(
    text: '¿Cuál es la velocidad máxima permitida en zonas urbanas?',
    options: [
      '40 km/h',
      '50 km/h',
      '60 km/h',
      '70 km/h',
    ],
    correctIndices: [1], // Se cambió a una lista de enteros
  ),
  // ... más preguntas
];