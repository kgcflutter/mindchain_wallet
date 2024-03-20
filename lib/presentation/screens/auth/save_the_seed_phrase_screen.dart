import 'package:flutter/material.dart';
import 'package:mindchain_wallet/conts/strings.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/auth/login_screen.dart';
import 'package:mindchain_wallet/presentation/utils/text_style.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

import '../../../widget/gredient_background_bottom.dart';
import '../../../widget/auth/seed_phrase_background.dart';
import '../../utils/copysystem.dart';

class SaveTheSeedPhraseScreen extends StatelessWidget {
  const SaveTheSeedPhraseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const Text(AllStrings.saveTheParseDes),
              const SizedBox(
                height: 35,
              ),
              SeedPhraseBackground(
                child: Consumer<CreateWalletProvider>(
                  builder: (context, value, child) => SizedBox(
                    width: 250,
                    child: value.mnemonicList.isEmpty
                        ? const CircularProgressIndicator()
                        : SizedBox(
                          height: 210,
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: value.mnemonicList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        _calculateCrossAxisCount(context),
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    mainAxisExtent: 27),
                            itemBuilder: (context, index) => Container(
                              alignment: Alignment.centerLeft,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text(
                                '${index + 1}. ${value.mnemonicList[index]}',
                                style:
                                    const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
              ),
              Consumer<CreateWalletProvider>(
                builder: (context, value, child) => GestureDetector(
                  onTap: () => mnemonicListCopyText(context, value.copyText),
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
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
              const SizedBox(height: 45,),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateCrossAxisCount(BuildContext context) {
    // Calculate the number of items that can fit horizontally
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount =
        (screenWidth / 150).floor(); // Adjust 150 according to your item size
    return crossAxisCount > 2 ? crossAxisCount : 2; // Minimum of 2 columns
  }
}
