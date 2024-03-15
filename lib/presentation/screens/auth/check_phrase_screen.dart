import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:provider/provider.dart';

class CheckPhraseScreen extends StatefulWidget {
  const CheckPhraseScreen({super.key});

  @override
  State<CheckPhraseScreen> createState() => _CheckPhraseScreenState();
}

class _CheckPhraseScreenState extends State<CheckPhraseScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CreateWalletProvider>(builder: (context, value, child) => Text("Balance: ${value.mindBalance}"),),
            TextField(
              controller: controller,
            ),
            Consumer<CreateWalletProvider>(
              builder: (context, value, child) => ElevatedButton(
                onPressed: () async {
                  if (1 == 1) {
                   String? privateKey = await value.getPrivateKey(controller.text);
                   value.checkBalance(privateKey!);
                    print(await value.getPublicKey(privateKey!));
                  } else {
                    print("false");
                  }
                },
                child: const Text("Check"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
