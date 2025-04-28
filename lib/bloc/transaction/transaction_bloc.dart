import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toropaal/models/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionLoadRequested>((event, emit) {
      // TODO: implement transaction load
    });
    on<TransactionAdded>((event, emit) {
      // TODO: implement transaction added
    });
    on<TransactionUpdated>((event, emit) {
      // TODO: implement transaction updated
    });
    on<TransactionDeleted>((event, emit) {
      // TODO: implement transaction deleted
    });
  }
}
