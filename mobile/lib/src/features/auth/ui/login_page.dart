import 'dart:async';

import 'package:finances_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:finances_app/src/features/auth/interactor/events/auth_events.dart';
import 'package:finances_app/src/features/auth/interactor/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final StreamSubscription _subscription;

  var email = '';
  var password = '';

  @override
  void initState() {
    super.initState();
    _subscription = context.read<AuthBloc>().stream.listen(
      (state) {
        if (state is FailedAuthState) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              content: Text(state.message),
              actions: [
                TextButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text('OK'),
                )
              ],
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AuthBloc>();
    final state = bloc.state;

    final isLoading = state is LoadingAuthState;

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                enabled: !isLoading,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Email obrigatório'),
                  Validatorless.email('Email inválido'),
                ]),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                enabled: !isLoading,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Senha inválida'),
                ]),
              ),
              const SizedBox(height: 20),
              if (isLoading) const CircularProgressIndicator(),
              if (!isLoading)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final event = LoginAuthEvent(
                          email: email,
                          password: password,
                        );
                        bloc.add(event);
                      }
                    },
                    child: const Text('Entrar'),
                  ),
                ),
              if (!isLoading)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      final event = GoogleLoginAuthEvent();
                      bloc.add(event);
                    },
                    child: const Text('Login com o Google'),
                  ),
                ),
              if (!isLoading)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pushNamed('signup');
                    },
                    child: const Text('Cadastrar-se'),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
