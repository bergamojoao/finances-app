import 'package:finances_app/src/features/auth/auth_module.dart';
import 'package:finances_app/src/features/auth/data/services/auth_service_impl.dart';
import 'package:finances_app/src/features/auth/data/services/google_auth_service_impl.dart';
import 'package:finances_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:finances_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:finances_app/src/features/auth/interactor/services/google_auth_service.dart';
import 'package:finances_app/src/features/bottom_bar/bottom_bar_module.dart';
import 'package:finances_app/src/features/finances/finances_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<AuthService>(AuthServiceImpl.new);
    i.add<GoogleAuthService>(GoogleAuthServiceImpl.new);
    i.addSingleton(AuthBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/auth', module: AuthModule());
    r.module('/bottom_bar', module: BottomBarModule());
    r.module('/finances', module: FinancesModule());
  }
}
