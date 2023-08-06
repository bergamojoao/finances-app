import 'package:finances_app/src/features/auth/interactor/dtos/signup_dto.dart';
import 'package:finances_app/src/features/auth/interactor/states/signup_state.dart';

import '../states/auth_state.dart';

abstract interface class AuthService {
  Future<AuthState> login(String email, String password);

  Future<AuthState> logout();

  Future<SignupState> signup(SignupDTO signupDTO);

  Future<AuthState> getUser();
}
