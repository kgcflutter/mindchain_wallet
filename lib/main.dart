import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/auth/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CreateWalletProvider(),)
  ],child: const MindWallet(),),);
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
