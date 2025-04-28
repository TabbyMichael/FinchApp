part of 'balance_bloc.dart';

abstract class BalanceEvent {
  const BalanceEvent();
}

class BalanceLoadRequested extends BalanceEvent {}

class BalanceUpdated extends BalanceEvent {
  final double newBalance;

  const BalanceUpdated(this.newBalance);
}
