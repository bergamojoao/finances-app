import 'package:finances_app/src/features/finances/interactor/entities/transaction_entity.dart';

import '../states/transactions_state.dart';

abstract interface class TransactionsService {
  Future<TransactionsState> save(TransactionEntity transaction);
}
