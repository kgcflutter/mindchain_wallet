import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12.0 : 24.0,
        ),
        child: Consumer<CreateWalletProvider>(
          builder: (context, value, child) => SingleChildScrollView(
            child: DefaultTabController(
              length: 2,
              child: buildLoginTabBar(isSmallScreen, value,
                  checkPhraseController, checkPrivateKeyController, context),
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
  }
}
