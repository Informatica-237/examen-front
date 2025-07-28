class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final String? imagePath; // <-- campo opcional para imagen

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    this.imagePath,
  });
}
