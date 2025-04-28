part of 'budget_bloc.dart';

abstract class BudgetEvent {
  const BudgetEvent();
}

class BudgetLoadRequested extends BudgetEvent {}

class BudgetAdded extends BudgetEvent {
  final Budget budget;

  const BudgetAdded(this.budget);
}

class BudgetUpdated extends BudgetEvent {
  final Budget budget;

  const BudgetUpdated(this.budget);
}

class BudgetDeleted extends BudgetEvent {
  final String budgetId;

  const BudgetDeleted(this.budgetId);
}
