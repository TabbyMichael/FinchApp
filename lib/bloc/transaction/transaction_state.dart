part of 'transaction_bloc.dart';

abstract class TransactionState {
  const TransactionState();
}

class TransactionInitial extends TransactionState {}

class TransactionLoadInProgress extends TransactionState {}

class TransactionLoadSuccess extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoadSuccess(this.transactions);
}

class TransactionOperationSuccess extends TransactionState {}

class TransactionFailure extends TransactionState {
  final String error;

  const TransactionFailure(this.error);
}
