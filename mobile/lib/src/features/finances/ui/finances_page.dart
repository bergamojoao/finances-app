import 'package:finances_app/src/features/finances/interactor/blocs/finances_bloc.dart';
import 'package:finances_app/src/features/finances/interactor/events/finances_events.dart';
import 'package:finances_app/src/features/finances/interactor/states/finances_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class FinancesPage extends StatefulWidget {
  const FinancesPage({super.key});

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<FinancesBloc>((bloc) => bloc.stream);
    final state = bloc.state;

    String actualMonth = '';

    if (state is InitialFinancesState) {
      actualMonth =
          DateFormat('MMMM yyyy').format(state.selectedMonth ?? DateTime.now());
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  bloc.add(const PreviousMonthFinancesEvent());
                },
                icon: const Icon(Icons.chevron_left),
                iconSize: 30,
                color: Colors.white,
              ),
              Container(
                alignment: Alignment.center,
                width: 180,
                child: Text(
                  actualMonth,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  bloc.add(const NextMonthFinancesEvent());
                },
                icon: const Icon(Icons.chevron_right),
                iconSize: 30,
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

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
