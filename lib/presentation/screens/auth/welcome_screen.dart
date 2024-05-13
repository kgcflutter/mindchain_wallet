import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mindchain_wallet/conts/strings.dart';
import 'package:mindchain_wallet/presentation/screens/auth/login_screen.dart';
import 'package:mindchain_wallet/presentation/screens/auth/save_the_seed_phrase_screen.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/text_style.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/presentation/widget/gredient_background_bottom.dart';

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
              Lottie.asset(
                AssetsPath.welcomeFirstJson,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(AllStrings.welcomeText,
                  style: TextStyler().textHeadingStyle),
              const Text(AllStrings.supportText),
              const SizedBox(
                height: 55,
              ),
              GredientBackgroundBtn(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaveTheSeedPhraseScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Create A New Wallet",
                  style: TextStyle(fontWeight: FontWeight.w500,),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                ),
                child: const Text(
                  "Sign In With Seed Phrase",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
