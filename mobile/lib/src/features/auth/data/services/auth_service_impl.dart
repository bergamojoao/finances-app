import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/configs/api_config.dart';
import '../../interactor/dtos/signup_dto.dart';
import '../../interactor/entities/user_entity.dart';
import '../../interactor/services/auth_service.dart';
import '../../interactor/states/auth_state.dart';
import '../../interactor/states/signup_state.dart';

class AuthServiceImpl implements AuthService {
  final api = ApiConfig.api;

  @override
  Future<AuthState> getUser() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      if (token != null) {
        var response = await api.get(
          '/auth/status',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        if (response.statusCode == 200) {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString('token', response.data['token']);
          return LoggedInAuthState(UserEntity(
            name: response.data['name'],
            email: response.data['email'],
            token: response.data['token'],
          ));
        }
      }
    } catch (e) {
      return const LoggedOutAuthState();
    }
    return const LoggedOutAuthState();
  }

  @override
  Future<AuthState> login(String email, String password) async {
    try {
      var response = await api.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['token']);
        return LoggedInAuthState(UserEntity(
          name: response.data['name'],
          email: response.data['email'],
          token: response.data['token'],
        ));
      }
    } on DioException catch (e) {
      log(e.toString());
      return const FailedAuthState('Usuário ou senha inválida');
    } catch (e) {
      return FailedAuthState(e.toString());
    }

    return const LoggedOutAuthState();
  }

  @override
  Future<AuthState> logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    return const LoggedOutAuthState();
  }

  @override
  Future<SignupState> signup(SignupDTO signupDTO) async {
    try {
      var response = await api.post(
        '/users',
        data: signupDTO.toJson(),
      );

      if (response.statusCode == 201) {
        return SubmitedSignupState(signupDTO);
      }
    } on DioException catch (e) {
      log(e.toString());
      return FailedSignupState(
        ApiConfig.apiErrorMessagesToString(e.response) ??
            'Erro ao se cadastrar.',
      );
    }
    return const FailedSignupState('Erro ao se cadastrar.');
  }
}
