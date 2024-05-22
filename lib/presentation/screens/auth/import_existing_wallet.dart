import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/widget/login_tabBar_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController checkPhraseController = TextEditingController();
  TextEditingController checkPrivateKeyController = TextEditingController();
  TextEditingController password1controller = TextEditingController();
  TextEditingController password2controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: const Text("Import Existing Wallet"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
      ),
      body: Consumer<CreateWalletProvider>(
        builder: (context, value, child) =>
            SingleChildScrollView(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                buildLoginTabBar(
                    isSmallScreen,
                    value,
                    checkPhraseController,
                    checkPrivateKeyController,
                    password1controller,
                    password2controller,
                    context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    checkPhraseController.dispose();
    checkPrivateKeyController.dispose();
    password1controller.dispose();
    password2controller.dispose();
  }
}
