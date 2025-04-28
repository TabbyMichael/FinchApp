class UserBalance {
  final double amount;
  final String currency;

  UserBalance({required this.amount, required this.currency});

  // Factory method to create a UserBalance from JSON data
  factory UserBalance.fromJson(Map<String, dynamic> json) {
    return UserBalance(
      amount: json['amount'].toDouble(),
      currency: json['currency'],
    );
  }

  // Convert UserBalance to JSON
  Map<String, dynamic> toJson() {
    return {'amount': amount, 'currency': currency};
  }
}
