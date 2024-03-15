import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindchain_wallet/conts/strings.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/auth/check_phrase_screen.dart';
import 'package:mindchain_wallet/presentation/utils/text_style.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

import '../../../widget/gredient_background_bottom.dart';
import '../../../widget/seed_phrase_background.dart';

class SaveTheSeedPhraseScreen extends StatelessWidget {
  const SaveTheSeedPhraseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                "Save The Seed Phrase",
                style: TextStyler().textHeadingStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(AllStrings.saveTheParseDes),
              ),
              const SizedBox(
                height: 35,
              ),
              SeedPhraseBackground(
                child: Consumer<CreateWalletProvider>(
                  builder: (context, value, child) => SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align text to the left
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        for (int i = 0; i < 12; i += 2)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${i + 1}. ${value.mnemonicList[i]}",
                                  style: const TextStyle(color: Colors.white)),
                              if (i + 1 < 12) const SizedBox(width: 30),
                              // Add SizedBox only if there's a next element
                              Text("${i + 2}. ${value.mnemonicList[i + 1]}",
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Consumer<CreateWalletProvider>(
                builder: (context, value, child) => GestureDetector(
                  onTap: () => value.mnemonicListCopyText(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.copy_all),
                      Text(
                        "Copy All Words",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckPhraseScreen(),
                      )),
                  child: GredientBackgroundBtn(
                    child: const Text(
                      "Check The phrase",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GredientBackgroundBtn(
                  child: const Text("Skip, i’ll take The Risk",
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
