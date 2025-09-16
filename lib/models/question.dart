class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final String? imagePath;  
  final String? description;

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    this.imagePath,
    this.description,
  });
}
