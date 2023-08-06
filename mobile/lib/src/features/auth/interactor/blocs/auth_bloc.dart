import 'package:finances_app/src/features/auth/interactor/services/google_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/auth_events.dart';
import '../services/auth_service.dart';
import '../states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService service;
  final GoogleAuthService googleAuthService;

  AuthBloc(this.service, this.googleAuthService)
      : super(const LoggedOutAuthState()) {
    on<LoginAuthEvent>(_loginAuthEvent);
    on<GoogleLoginAuthEvent>(_googleLoginAuthEvent);
    on<LogoutAuthEvent>(_logoutAuthEvent);
    on<CheckAuthEvent>(_checkAuthEvent);
  }

  void _loginAuthEvent(LoginAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    final newState = await service.login(
      event.email,
      event.password,
    );
    emit(newState);
  }

  void _googleLoginAuthEvent(GoogleLoginAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    final newState = await googleAuthService.signin();
    emit(newState);
  }

  void _logoutAuthEvent(LogoutAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    final newState = await service.logout();
    emit(newState);
  }

  void _checkAuthEvent(CheckAuthEvent event, emit) async {
    // emit(const LoadingAuthState());
    final newState = await service.getUser();
    emit(newState);
  }
}
