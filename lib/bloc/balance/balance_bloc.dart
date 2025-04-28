import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc() : super(BalanceInitial()) {
    on<BalanceLoadRequested>((event, emit) {
      // TODO: implement balance load
    });
    on<BalanceUpdated>((event, emit) {
      // TODO: implement balance updated
    });
  }
}
