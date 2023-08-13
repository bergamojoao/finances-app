import 'dart:async';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:finances_app/src/features/finances/interactor/blocs/transactions_bloc.dart';
import 'package:finances_app/src/features/finances/interactor/entities/transaction_entity.dart';
import 'package:finances_app/src/features/finances/interactor/events/transactions_events.dart';
import 'package:finances_app/src/features/finances/interactor/states/transactions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late final StreamSubscription _subscription;

  final CurrencyTextInputFormatter moneyFormatter =
      CurrencyTextInputFormatter(locale: 'pt-BR', symbol: 'R\$');

  final _formKey = GlobalKey<FormState>();

  var transaction = TransactionEntity(date: DateTime.now());

  @override
  void initState() {
    super.initState();
    _subscription = context.read<TransactionsBloc>().stream.listen((state) {
      if (state is SucessfullTransactionsState) {
        Modular.to.pop();
      }
      if (state is ErrorTransactionsState) {
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var transactionsBloc =
        context.watch<TransactionsBloc>((bloc) => bloc.stream);
    var state = transactionsBloc.state;

    var isLoading = state is LoadingTransactionsState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: transaction.date?.toIso8601String(),
                          // onChanged: (value) {
                          //   transaction.description = value;
                          // },
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Data',
                          ),
                          // validator: Validatorless.multiple([
                          //   Validatorless.required('Preecha este campo'),
                          // ]),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String?>(
                          value: transaction.type,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tipo',
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.required('Preecha este campo.'),
                          ]),
                          items: ['incomings', 'outgoings']
                              .map(
                                (i) => DropdownMenuItem<String>(
                                  value: i,
                                  child: Text(i),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            transaction.type = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: transaction.description,
                          onChanged: (value) {
                            transaction.description = value;
                          },
                          // enabled: !isLoading,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Descrição',
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.required('Preecha este campo'),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String?>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Categoria',
                          ),
                          items: ['food', 'bills']
                              .map(
                                (i) => DropdownMenuItem<String>(
                                  value: i,
                                  child: Text(i),
                                ),
                              )
                              .toList(),
                          value: transaction.category,
                          onChanged: (value) {
                            transaction.category = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          inputFormatters: [moneyFormatter],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          initialValue: transaction.value?.toString(),
                          onChanged: (value) {
                            transaction.value =
                                moneyFormatter.getUnformattedValue().toDouble();
                          },
                          // enabled: !isLoading,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Valor',
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.required('Preecha este campo.'),
                          ]),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      transactionsBloc.add(SubmitTransactionEvent(transaction));
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Salvar',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
