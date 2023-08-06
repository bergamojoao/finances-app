sealed class AuthEvent {
  const AuthEvent();
}

class LoginAuthEvent implements AuthEvent {
  final String email;
  final String password;

  const LoginAuthEvent({
    required this.email,
    required this.password,
  });
}

class GoogleLoginAuthEvent implements AuthEvent {}

class LogoutAuthEvent implements AuthEvent {}

class CheckAuthEvent implements AuthEvent {}
