import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'src/app_widget.dart';
import 'src/features/app_module.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const MainApp(),
    ),
  );
}
