class Transaction {
  final String id;
  final double amount;
  final String currency;
  final String recipientName;
  final String recipientAccount;
  final DateTime date;
  final String status;

  Transaction({
    required this.id,
    required this.amount,
    required this.currency,
    required this.recipientName,
    required this.recipientAccount,
    required this.date,
    required this.status,
  });

  // Factory method to create a Transaction from JSON data
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      recipientName: json['recipientName'],
      recipientAccount: json['recipientAccount'],
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }

  // Convert Transaction to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'currency': currency,
      'recipientName': recipientName,
      'recipientAccount': recipientAccount,
      'date': date.toIso8601String(),
      'status': status,
    };
  }
}
