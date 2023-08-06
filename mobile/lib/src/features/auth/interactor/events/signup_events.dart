import '../dtos/signup_dto.dart';

sealed class SignupEvent {
  const SignupEvent();
}

class SubmitSignupEvent implements SignupEvent {
  final SignupDTO signupDTO;

  const SubmitSignupEvent({
    required this.signupDTO,
  });
}
