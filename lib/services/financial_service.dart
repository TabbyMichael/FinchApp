import '../models/budget.dart';
import '../models/savings_goal.dart';

class FinancialService {
  // Simulate fetching user budgets
  Future<List<Budget>> getUserBudgets() async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return [
      Budget(
        id: 'budget1',
        category: 'Food & Dining',
        limit: 500.0,
        spent: 320.75,
        currency: 'USD',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      ),
      Budget(
        id: 'budget2',
        category: 'Entertainment',
        limit: 200.0,
        spent: 175.50,
        currency: 'USD',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      ),
      Budget(
        id: 'budget3',
        category: 'Transportation',
        limit: 150.0,
        spent: 82.25,
        currency: 'USD',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      ),
      Budget(
        id: 'budget4',
        category: 'Shopping',
        limit: 300.0,
        spent: 412.30,
        currency: 'USD',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      ),
    ];
  }

  // Simulate fetching user savings goals
  Future<List<SavingsGoal>> getSavingsGoals() async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return [
      SavingsGoal(
        id: 'goal1',
        title: 'Vacation Fund',
        description: 'Trip to Bali next summer',
        targetAmount: 3000.0,
        currentAmount: 1250.0,
        currency: 'USD',
        targetDate: DateTime.now().add(const Duration(days: 180)),
        createdDate: DateTime.now().subtract(const Duration(days: 60)),
        imageUrl:
            'https://images.unsplash.com/photo-1539367628448-4bc5c9d171c8',
      ),
      SavingsGoal(
        id: 'goal2',
        title: 'New Laptop',
        description: 'MacBook Pro for work',
        targetAmount: 2000.0,
        currentAmount: 800.0,
        currency: 'USD',
        targetDate: DateTime.now().add(const Duration(days: 90)),
        createdDate: DateTime.now().subtract(const Duration(days: 45)),
        imageUrl:
            'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
      ),
      SavingsGoal(
        id: 'goal3',
        title: 'Emergency Fund',
        description: '6 months of expenses',
        targetAmount: 10000.0,
        currentAmount: 3500.0,
        currency: 'USD',
        targetDate: DateTime.now().add(const Duration(days: 365)),
        createdDate: DateTime.now().subtract(const Duration(days: 120)),
      ),
    ];
  }

  // Simulate creating a new budget
  Future<Budget> createBudget(Budget budget) async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    // Return the budget with a generated ID (in a real app, this would come from the backend)
    return budget;
  }

  // Simulate creating a new savings goal
  Future<SavingsGoal> createSavingsGoal(SavingsGoal goal) async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    // Return the goal with a generated ID (in a real app, this would come from the backend)
    return goal;
  }

  // Simulate updating a budget
  Future<Budget> updateBudget(Budget budget) async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return budget;
  }

  // Simulate updating a savings goal
  Future<SavingsGoal> updateSavingsGoal(SavingsGoal goal) async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return goal;
  }
}
