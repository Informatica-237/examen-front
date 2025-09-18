class Question {
  final String text;
  final List<String> options;
  final List<int> correctIndices; // Change to a list
  final String? imagePath;
  final String? description;

  Question({
    required this.text,
    required this.options,
    required this.correctIndices, // Update the constructor
    this.imagePath,
    this.description,
  });
}