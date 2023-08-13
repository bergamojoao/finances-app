import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/transactions_events.dart';
import '../services/transactions_service.dart';
import '../states/transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionEvent, TransactionsState> {
  final TransactionsService service;
  TransactionsBloc(this.service) : super(const InitialTransactionsState()) {
    on<SubmitTransactionEvent>(_submitTransactionEvent);
  }

  _submitTransactionEvent(SubmitTransactionEvent event, emit) async {
    emit(const LoadingTransactionsState());
    var newState = await service.save(event.transaction);
    emit(newState);
  }
}
