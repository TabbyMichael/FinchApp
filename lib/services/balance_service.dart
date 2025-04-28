import '../models/user_balance.dart';

class BalanceService {
  // Simulate fetching user balance
  Future<UserBalance> getUserBalance() async {
    // This would normally be an API call to a backend service
    // For now, we'll return mock data
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return UserBalance(amount: 1250.75, currency: 'USD');
  }
}
