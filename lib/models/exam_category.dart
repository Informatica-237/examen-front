// Archivo: lib/models/exam_category.dart
class ExamCategory {
  final String name;
  final String imagePath;
  final String? description;

  ExamCategory({
    required this.name,
    required this.imagePath,
    this.description,
  });
}