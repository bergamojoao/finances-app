sealed class TransactionsState {
  const TransactionsState();
}

class InitialTransactionsState extends TransactionsState {
  const InitialTransactionsState();
}

class LoadingTransactionsState extends TransactionsState {
  const LoadingTransactionsState();
}

class SucessfullTransactionsState extends TransactionsState {
  const SucessfullTransactionsState();
}

class ErrorTransactionsState extends TransactionsState {
  final String message;
  const ErrorTransactionsState(this.message);
}
