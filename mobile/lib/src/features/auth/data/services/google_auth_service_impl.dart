import 'dart:developer';

import 'package:finances_app/src/core/utils/api_services.dart';
import 'package:finances_app/src/features/auth/interactor/services/google_auth_service.dart';
import 'package:finances_app/src/features/auth/interactor/states/auth_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../interactor/entities/user_entity.dart';

class GoogleAuthServiceImpl implements GoogleAuthService {
  final api = ApiService.api;

  final _googleSignIn = GoogleSignIn();

  @override
  Future<AuthState> signin() async {
    try {
      var response = await _googleSignIn.signIn();
      if (response != null) {
        var googleAuth = await response.authentication;

        var apiResponse = await api.post('/google-auth', data: {
          'token': googleAuth.accessToken,
        });

        if (apiResponse.statusCode == 201) {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString('token', apiResponse.data['token']);
          return LoggedInAuthState(
            UserEntity(
              name: apiResponse.data['name'],
              email: apiResponse.data['email'],
              token: apiResponse.data['token'],
            ),
          );
        }
      }
    } catch (e) {
      log(e.toString());
      return const FailedAuthState('Erro ao realizar login pelo google');
    }
    return const LoggedOutAuthState();
  }
}
