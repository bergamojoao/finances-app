sealed class FinancesEvent {
  const FinancesEvent();
}

class NextMonthFinancesEvent implements FinancesEvent {
  const NextMonthFinancesEvent();
}

class PreviousMonthFinancesEvent implements FinancesEvent {
  const PreviousMonthFinancesEvent();
}
