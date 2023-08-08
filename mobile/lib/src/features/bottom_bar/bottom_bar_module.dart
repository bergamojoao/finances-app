import 'package:finances_app/src/features/bottom_bar/ui/bottom_bar_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../finances/finances_module.dart';

class BottomBarModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const BottomBarPage(),
      children: [
        ModuleRoute('/finances', module: FinancesModule()),
      ],
    );
  }
}
