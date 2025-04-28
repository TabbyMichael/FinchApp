part of 'budget_bloc.dart';

abstract class BudgetState {
  const BudgetState();
}

class BudgetInitial extends BudgetState {}

class BudgetLoadInProgress extends BudgetState {}

class BudgetLoadSuccess extends BudgetState {
  final List<Budget> budgets;

  const BudgetLoadSuccess(this.budgets);
}

class BudgetOperationSuccess extends BudgetState {}

class BudgetFailure extends BudgetState {
  final String error;

  const BudgetFailure(this.error);
}
