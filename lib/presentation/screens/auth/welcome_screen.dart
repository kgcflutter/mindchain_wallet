import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/conts/strings.dart';
import 'package:mindchain_wallet/presentation/screens/auth/login_screen.dart';
import 'package:mindchain_wallet/presentation/screens/auth/save_the_seed_phrase_screen.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/text_style.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/widget/gredient_background_bottom.dart';
import 'package:provider/provider.dart';

import '../../provider/create_new_wallet_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AssetsPath.welcomeFirstImages,
                  width: double.infinity, height: 250),
              const SizedBox(
                height: 15,
              ),
              Text(AllStrings.welcomeText,
                  style: TextStyler().textHeadingStyle),
              const Text(AllStrings.supportText),
              const SizedBox(
                height: 55,
              ),
               GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaveTheSeedPhraseScreen(),
                    ),
                  );
                  Provider.of<CreateWalletProvider>(context, listen: false).createWallet();
                },
                child: GredientBackgroundBtn(
                  child: const Text(
                    "Create A New Wallet",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),),
                child: GredientBackgroundBtn(
                  child: const Text("Sign In With Seed Phrase",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
