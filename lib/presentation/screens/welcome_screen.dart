import 'package:flutter/material.dart';
import 'package:mindchain_wallet/conts/strings.dart';
import 'package:mindchain_wallet/presentation/screens/save_the_seed_phrase_screen.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/text_style.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/widget/gredient_background_bottom.dart';

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
              Text(AllStrings.supportText),
              const SizedBox(
                height: 55,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaveTheSeedPhraseScreen(),
                    )),
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
              GredientBackgroundBtn(
                child: const Text("I Already Have Account",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
