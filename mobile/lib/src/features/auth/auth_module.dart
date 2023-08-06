import 'package:flutter_modular/flutter_modular.dart';

import 'interactor/blocs/signup_bloc.dart';
import 'ui/login_page.dart';
import 'ui/signup_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(SignupBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/login', child: (_) => const LoginPage());
    r.child('/signup', child: (_) => const SignupPage());
  }
}
