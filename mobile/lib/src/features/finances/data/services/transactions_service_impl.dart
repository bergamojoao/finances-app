import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finances_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:finances_app/src/features/auth/interactor/states/auth_state.dart';
import 'package:finances_app/src/features/finances/interactor/entities/transaction_entity.dart';
import 'package:finances_app/src/features/finances/interactor/states/transactions_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/configs/api_config.dart';
import '../../interactor/services/transactions_service.dart';

class TransactionsServiceImpl implements TransactionsService {
  final api = ApiConfig.api;

  @override
  Future<TransactionsState> save(TransactionEntity transaction) async {
    try {
      var authState = Modular.get<AuthBloc>().state;
      if (authState is LoggedInAuthState) {
        final response = await api.post(
          '/transactions',
          data: transaction.toJson(),
          options: Options(
            headers: {'Authorization': 'Bearer ${authState.user.token}'},
          ),
        );
        if (response.statusCode == 201) {
          return const SucessfullTransactionsState();
        }
      }
    } on DioException catch (e) {
      log(e.toString());
      return ErrorTransactionsState(
        ApiConfig.apiErrorMessagesToString(e.response) ??
            'Erro ao se cadastrar.',
      );
    } catch (e) {
      log(e.toString());
    }
    return const ErrorTransactionsState('Erro ao cadastrar.');
  }
}
