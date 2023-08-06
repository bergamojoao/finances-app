import 'dart:async';

import 'package:finances_app/src/features/auth/interactor/blocs/signup_bloc.dart';
import 'package:finances_app/src/features/auth/interactor/dtos/signup_dto.dart';
import 'package:finances_app/src/features/auth/interactor/events/signup_events.dart';
import 'package:finances_app/src/features/auth/interactor/states/auth_state.dart';
import 'package:finances_app/src/features/auth/interactor/states/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final StreamSubscription _subscription;

  var signupDTO = SignupDTO(
    name: '',
    email: '',
    password: '',
  );

  @override
  void initState() {
    super.initState();
    _subscription = context.read<SignupBloc>().stream.listen(
      (state) {
        if (state is SubmitedSignupState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Usuário cadastrado'),
              content: const Text('Você ja pode realizar seu login'),
              actions: [
                TextButton(
                  onPressed: () => Modular.to.navigate('login'),
                  child: const Text('OK'),
                )
              ],
            ),
          );
        }
        if (state is FailedSignupState) {
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
    final bloc = context.watch<SignupBloc>();
    final state = bloc.state;

    final formKey = GlobalKey<FormState>();

    final isLoading = state is LoadingAuthState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: signupDTO.name,
                  onChanged: (value) {
                    signupDTO.name = value;
                  },
                  enabled: !isLoading,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  validator: Validatorless.required('Preencha este campo.'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    signupDTO.email = value;
                  },
                  enabled: !isLoading,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Preencha este campo.'),
                    Validatorless.email('Email inválido'),
                  ]),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    signupDTO.password = value;
                  },
                  enabled: !isLoading,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  validator: Validatorless.required('Preencha este campo.'),
                ),
                const SizedBox(height: 20),
                if (isLoading) const CircularProgressIndicator(),
                if (!isLoading)
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final event = SubmitSignupEvent(signupDTO: signupDTO);
                        bloc.add(event);
                      }
                    },
                    child: const Text('Cadastrar-se'),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
