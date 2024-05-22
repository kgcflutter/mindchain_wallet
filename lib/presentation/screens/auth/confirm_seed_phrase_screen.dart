import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/widget/auth/login_system_widget.dart';
import 'package:mindchain_wallet/presentation/widget/login_tabBar_widget.dart';
import 'package:provider/provider.dart';

class ImportExistingWallet extends StatefulWidget {
  const ImportExistingWallet({super.key});

  @override
  State<ImportExistingWallet> createState() => _ImportExistingWalletState();
}

class _ImportExistingWalletState extends State<ImportExistingWallet> {

  TextEditingController checkPhraseController = TextEditingController();
  TextEditingController checkPrivateKeyController = TextEditingController();
  TextEditingController password1controller = TextEditingController();
  TextEditingController password2controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Confirm Seed Phrase"),
      ),
      body: Consumer<CreateWalletProvider>(builder: (context, value, child) => Column(children: [
        LoginSystemWidget(
          isSmallScreen: true,
          value: value,
          hintText: 'Enter Your Seed Phrase',
          inputController: checkPhraseController,
          button: loginSeedPhraseButton(context, checkPhraseController,
              password1controller,password2controller),
          password1Controller: password1controller,
          password2Controller: password2controller,
        ),
      ]),),
    );
  }
}
