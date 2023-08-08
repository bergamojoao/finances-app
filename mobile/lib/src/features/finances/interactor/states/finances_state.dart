sealed class FinancesState {
  final DateTime? selectedMonth;
  const FinancesState({this.selectedMonth});
}

class InitialFinancesState extends FinancesState {
  const InitialFinancesState({required DateTime selectedMonth})
      : super(selectedMonth: selectedMonth);
}

class LoadingFinancesState extends FinancesState {
  const LoadingFinancesState();
}
