import 'package:flutter_modular/flutter_modular.dart';

import '../../core/configs/bloc_config.dart';
import 'interactor/blocs/finances_bloc.dart';
import 'ui/add.dart';
import 'ui/finances_page.dart';

class FinancesModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<FinancesBloc>(
      FinancesBloc.new,
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
