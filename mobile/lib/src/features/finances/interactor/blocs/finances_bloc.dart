import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/finances_events.dart';
import '../states/finances_state.dart';

class FinancesBloc extends Bloc<FinancesEvent, FinancesState> {
  FinancesBloc() : super(InitialFinancesState(selectedMonth: DateTime.now())) {
    on<NextMonthFinancesEvent>(_nextMonthFinancesEvent);
    on<PreviousMonthFinancesEvent>(_previousMonthFinancesEvent);
  }

  _nextMonthFinancesEvent(NextMonthFinancesEvent event, emit) async {
    var actualMonth = state.selectedMonth ?? DateTime.now();
    var nextMonth = DateTime(
      actualMonth.year,
      actualMonth.month + 1,
      actualMonth.day,
    );
    emit(InitialFinancesState(selectedMonth: nextMonth));
  }

  _previousMonthFinancesEvent(PreviousMonthFinancesEvent event, emit) async {
    var actualMonth = state.selectedMonth ?? DateTime.now();
    var previousMonth = DateTime(
      actualMonth.year,
      actualMonth.month - 1,
      actualMonth.day,
    );
    emit(InitialFinancesState(selectedMonth: previousMonth));
  }
}
