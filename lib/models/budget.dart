class Budget {
  final String id;
  final String category;
  final double limit;
  final double spent;
  final String currency;
  final DateTime startDate;
  final DateTime endDate;

  Budget({
    required this.id,
    required this.category,
    required this.limit,
    required this.spent,
    required this.currency,
    required this.startDate,
    required this.endDate,
  });

  // Calculate percentage spent
  double get percentageSpent => spent / limit;

  // Check if over budget
  bool get isOverBudget => spent > limit;

  // Calculate remaining amount
  double get remaining => limit - spent;

  // Factory method to create a Budget from JSON data
  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      category: json['category'],
      limit: json['limit'].toDouble(),
      spent: json['spent'].toDouble(),
      currency: json['currency'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  // Convert Budget to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'limit': limit,
      'spent': spent,
      'currency': currency,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
