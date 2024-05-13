import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/sign_in.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/dashboard_screen.dart';
import 'package:mindchain_wallet/presentation/widget/auth/login_system_widget.dart';
import 'package:mindchain_wallet/presentation/widget/gredient_background_bottom.dart';
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
          horizontal: isSmallScreen
              ? 12.0
              : 24.0, // Adjust padding based on screen size
        ),
        child: Consumer<CreateWalletProvider>(
          builder: (context, value, child) => SingleChildScrollView(
            child: DefaultTabController(
              length: 2,
              child: buildLoginTabBar(isSmallScreen, value),
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

  Widget buildLoginTabBar(bool isSmallScreen, CreateWalletProvider value) {
    return Column(
      children: <Widget>[
        const TabBar(
          indicatorPadding: EdgeInsetsDirectional.all(2),
          tabs: [
            Tab(text: 'Seed Phrase'),
            Tab(text: 'Private Key'),
          ],
        ),
        SizedBox(
          height: 400,
          child: TabBarView(children: [
            LoginSystemWidget(
              isSmallScreen: isSmallScreen,
              value: value,
              hintText: 'Enter Your Seed Phrase',
              inputController: checkPhraseController,
              button: GredientBackgroundBtn(
                onTap: () async {
                  await SignInSystem.importWallet(checkPhraseController.text)
                      .then(
                    (value) {
                      if (value == true) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                            (route) => false);
                      }
                    },
                  );
                },
                child: const Text("Submit"),
              ),
            ),
            LoginSystemWidget(
              isSmallScreen: isSmallScreen,
              value: value,
              hintText: "Enter Your Private Key Then Submit",
              inputController: checkPrivateKeyController,
              button: GredientBackgroundBtn(
                onTap: () async {
                  await SignInSystem.loginWithPrivateKey(
                          checkPrivateKeyController.text)
                      .then(
                    (value) {
                      if (value == true) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                            (route) => false);
                      }
                    },
                  );
                },
                child: const Text("Submit"),
              ),
            ),
          ]),
        )
      ],
    );
  }
}
