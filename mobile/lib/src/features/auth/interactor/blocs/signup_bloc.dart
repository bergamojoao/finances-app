import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/signup_events.dart';
import '../services/auth_service.dart';
import '../states/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthService service;

  SignupBloc(this.service) : super(const InitialSignupState()) {
    on<SubmitSignupEvent>(_submitSignupEvent);
  }

  void _submitSignupEvent(SubmitSignupEvent event, emit) async {
    emit(const LoadingSignupState());
    final newState = await service.signup(event.signupDTO);
    emit(newState);
  }
}
