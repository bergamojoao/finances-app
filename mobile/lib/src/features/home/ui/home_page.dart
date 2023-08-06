import 'package:finances_app/src/features/auth/interactor/events/auth_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../auth/interactor/blocs/auth_bloc.dart';
import '../../auth/interactor/states/auth_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AuthBloc>();
    final state = bloc.state;

    late Widget child;

    if (state is LoggedInAuthState) {
      child = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ola, ${state.user.name}'),
          ElevatedButton(
            onPressed: () {
              final event = LogoutAuthEvent();
              bloc.add(event);
            },
            child: const Text('Logout'),
          )
        ],
      );
    } else {
      child = const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nao logado!'),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_left),
              color: Colors.white,
            ),
            const Text(
              'Agosto 2023',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right),
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.arrow_upward),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Receitas'),
                            Text(
                              'R\$ 3.333,00',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.arrow_downward),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Despesas'),
                            Text(
                              'R\$ 3.333,00',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
