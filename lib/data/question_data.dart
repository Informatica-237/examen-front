// lib/data/question_data.dart

import '../models/question.dart';
import '../models/exam_category.dart';
import 'categoria-a.dart';
import 'categoria-b.dart';
import 'categoria-cye.dart';

final Map<String, List<Question>> questionBank = {
  'Categoria A': categoriaAQuestions,
  'Categoria B': categoriaBQuestions,
  'Categoria C Y E': categoriaCEQuestions,
};


final List<ExamCategory> categories = [
  ExamCategory(
    name: 'Categoria A', // Cambiado de 'CLASE A'
    imagePath: 'assets/icon/categorias/categoria-a.png',
    description: 'Motovehículos de dos ruedas',
  ),
  ExamCategory(
    name: 'Categoria B', // Cambiado de 'CLASE B'
    imagePath: 'assets/icon/categorias/categoria-b.png',
    description: 'Automóviles, camionetas y utilitarios',
  ),
  ExamCategory(
    name: 'Categoria C Y E', // Cambiado de 'CLASE C Y E'
    imagePath: 'assets/icon/categorias/categoria-cye.png',
    description: 'Carga, camiones y maquinarias no agrícolas',
  ),
];