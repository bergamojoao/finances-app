import 'package:finances_app/src/features/finances/interactor/entities/transaction_entity.dart';

sealed class TransactionEvent {
  const TransactionEvent();
}

class SubmitTransactionEvent implements TransactionEvent {
  final TransactionEntity transaction;
  const SubmitTransactionEvent(this.transaction);
}
