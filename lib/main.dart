import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/screens/welcome_screen.dart';

void main() {
  runApp(const MindWallet(),);
}

class MindWallet extends StatelessWidget {
  const MindWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomeScreen(),
    );
  }
}
