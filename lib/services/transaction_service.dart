import 'dart:convert';
import '../models/transaction.dart';

class TransactionService {
  // Simulate fetching transaction history
  Future<List<Transaction>> getTransactionHistory() async {
    // This would normally be an API call to a backend service
    // For now, we'll return mock data
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    return [
      Transaction(
        id: 'tx1',
        amount: 250.00,
        currency: 'USD',
        recipientName: 'John Doe',
        recipientAccount: 'john.doe@example.com',
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: 'Completed',
      ),
      Transaction(
        id: 'tx2',
        amount: 100.00,
        currency: 'EUR',
        recipientName: 'Jane Smith',
        recipientAccount: 'jane.smith@example.com',
        date: DateTime.now().subtract(const Duration(days: 5)),
        status: 'Completed',
      ),
      Transaction(
        id: 'tx3',
        amount: 75.50,
        currency: 'GBP',
        recipientName: 'Robert Johnson',
        recipientAccount: 'robert.j@example.com',
        date: DateTime.now().subtract(const Duration(hours: 12)),
        status: 'Processing',
      ),
    ];
  }

  // Simulate sending money
  Future<Transaction> sendMoney({
    required double amount,
    required String currency,
    required String recipientName,
    required String recipientAccount,
  }) async {
    // This would normally involve blockchain API integration
    // For now, we'll simulate a successful transaction
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simulate processing time

    // Generate a unique transaction ID
    final id = 'tx${DateTime.now().millisecondsSinceEpoch}';

    return Transaction(
      id: id,
      amount: amount,
      currency: currency,
      recipientName: recipientName,
      recipientAccount: recipientAccount,
      date: DateTime.now(),
      status: 'Processing',
    );
  }

  // Simulate fetching exchange rates
  Future<Map<String, double>> getExchangeRates(String baseCurrency) async {
    // This would normally be an API call to a currency exchange rate service
    // For now, we'll return mock data
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Mock exchange rates relative to USD
    final mockRates = {
      'USD': 1.0,
      'EUR': 0.85,
      'GBP': 0.73,
      'JPY': 110.15,
      'CAD': 1.25,
      'AUD': 1.35,
      'CHF': 0.92,
    };

    return mockRates;
  }
}
