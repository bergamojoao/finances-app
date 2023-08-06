import '../states/auth_state.dart';

abstract interface class GoogleAuthService {
  Future<AuthState> signin();
}
