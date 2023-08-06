import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/bottom_bar.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Expanded(child: RouterOutlet()),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
