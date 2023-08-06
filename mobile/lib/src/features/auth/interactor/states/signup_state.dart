import 'package:finances_app/src/features/auth/interactor/dtos/signup_dto.dart';

sealed class SignupState {
  const SignupState();
}

class InitialSignupState implements SignupState {
  const InitialSignupState();
}

class SubmitedSignupState implements SignupState {
  final SignupDTO signupDTO;
  const SubmitedSignupState(this.signupDTO);
}

class FailedSignupState implements SignupState {
  final String message;
  const FailedSignupState(this.message);
}

class LoadingSignupState implements SignupState {
  const LoadingSignupState();
}
