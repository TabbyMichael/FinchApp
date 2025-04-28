part of 'balance_bloc.dart';

abstract class BalanceState {
  const BalanceState();
}

class BalanceInitial extends BalanceState {}

class BalanceLoadInProgress extends BalanceState {}

class BalanceLoadSuccess extends BalanceState {
  final double balance;

  const BalanceLoadSuccess(this.balance);
}

class BalanceOperationSuccess extends BalanceState {}

class BalanceFailure extends BalanceState {
  final String error;

  const BalanceFailure(this.error);
}
