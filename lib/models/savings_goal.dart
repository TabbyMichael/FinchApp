class SavingsGoal {
  final String id;
  final String title;
  final String description;
  final double targetAmount;
  final double currentAmount;
  final String currency;
  final DateTime targetDate;
  final DateTime createdDate;
  final String imageUrl; // Optional image to represent the goal

  SavingsGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.currentAmount,
    required this.currency,
    required this.targetDate,
    required this.createdDate,
    this.imageUrl = '',
  });

  // Calculate percentage completed
  double get percentageCompleted => currentAmount / targetAmount;

  // Check if goal is achieved
  bool get isAchieved => currentAmount >= targetAmount;

  // Calculate remaining amount
  double get remainingAmount => targetAmount - currentAmount;

  // Calculate days remaining until target date
  int get daysRemaining {
    final now = DateTime.now();
    return targetDate.difference(now).inDays;
  }

  // Factory method to create a SavingsGoal from JSON data
  factory SavingsGoal.fromJson(Map<String, dynamic> json) {
    return SavingsGoal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      targetAmount: json['targetAmount'].toDouble(),
      currentAmount: json['currentAmount'].toDouble(),
      currency: json['currency'],
      targetDate: DateTime.parse(json['targetDate']),
      createdDate: DateTime.parse(json['createdDate']),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // Convert SavingsGoal to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'currency': currency,
      'targetDate': targetDate.toIso8601String(),
      'createdDate': createdDate.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}
