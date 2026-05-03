class AdviceController {
  final int id;
  final String advice;

  AdviceController({required this.id, required this.advice});

  factory AdviceController.fromJson(Map<String, dynamic> json) {
    return AdviceController(
      id: json['slip']['id'],
      advice: json['slip']['advice'],
    );
  }
}
