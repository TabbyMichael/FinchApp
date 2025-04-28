part of 'transaction_bloc.dart';

abstract class TransactionEvent {
  const TransactionEvent();
}

class TransactionLoadRequested extends TransactionEvent {}

class TransactionAdded extends TransactionEvent {
  final Transaction transaction;

  const TransactionAdded(this.transaction);
}

class TransactionUpdated extends TransactionEvent {
  final Transaction transaction;

  const TransactionUpdated(this.transaction);
}

class TransactionDeleted extends TransactionEvent {
  final String transactionId;

  const TransactionDeleted(this.transactionId);
}
