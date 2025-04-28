import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toropaal/models/budget.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(BudgetInitial()) {
    on<BudgetLoadRequested>((event, emit) {
      // TODO: implement budget load
    });
    on<BudgetAdded>((event, emit) {
      // TODO: implement budget added
    });
    on<BudgetUpdated>((event, emit) {
      // TODO: implement budget updated
    });
    on<BudgetDeleted>((event, emit) {
      // TODO: implement budget deleted
    });
  }
}
