import 'package:finances_app/src/features/finances/data/services/transactions_service_impl.dart';
import 'package:finances_app/src/features/finances/interactor/services/transactions_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/configs/bloc_config.dart';
import 'interactor/blocs/finances_bloc.dart';
import 'interactor/blocs/transactions_bloc.dart';
import 'ui/add.dart';
import 'ui/finances_page.dart';

class FinancesModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<FinancesBloc>(
      FinancesBloc.new,
      config: blocConfig(),
    );
    i.addSingleton<TransactionsService>(TransactionsServiceImpl.new);
    i.addSingleton<TransactionsBloc>(
      TransactionsBloc.new,
      config: blocConfig(),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const FinancesPage());
    r.child(
      '/add',
      child: (_) => const AddPage(),
      transition: TransitionType.downToUp,
    );
  }
}
