import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final CurrencyTextInputFormatter moneyFormatter =
      CurrencyTextInputFormatter(locale: 'pt-BR', symbol: 'R\$');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String?>(
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
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          // email = value;
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
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        inputFormatters: [moneyFormatter],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          // email = value;
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
                    ],
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
                      Modular.to.pop();
                    }
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
