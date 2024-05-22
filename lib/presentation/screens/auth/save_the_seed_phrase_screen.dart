import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/auth/confirm_seed_phrase_screen.dart';
import 'package:mindchain_wallet/presentation/screens/auth/import_existing_wallet.dart';
import 'package:mindchain_wallet/presentation/screens/MainBottomNavBarScreen.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import 'package:mindchain_wallet/presentation/widget/gredient_background_bottom.dart';
import 'package:provider/provider.dart';

class SaveTheSeedPhraseScreen extends StatefulWidget {
  const SaveTheSeedPhraseScreen({Key? key}) : super(key: key);

  @override
  State<SaveTheSeedPhraseScreen> createState() =>
      _SaveTheSeedPhraseScreenState();
}

class _SaveTheSeedPhraseScreenState extends State<SaveTheSeedPhraseScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 300),
      () => Provider.of<CreateWalletProvider>(context, listen: false)
          .createWallet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: const Text("Save The Seed Phrase"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Consumer<CreateWalletProvider>(
                builder: (context, value, child) => Visibility(
                    visible: value.mnemonicList.isNotEmpty,
                    replacement: const CupertinoActivityIndicator(
                      color: Colors.orange,
                    ),
                    child: seedPhraseListWidget(value, context)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Consumer<CreateWalletProvider>(
              builder: (context, value, child) => GestureDetector(
                onTap: () => mnemonicListCopyText(context, value.copyText),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.copy_all,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Copy All Words",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GredientBackgroundBtn(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImportExistingWallet(),
                  ),
                ),
                child: const Text(
                  "Check The phrase",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainBottomNavBarScreen(),
                    ),
                  );
                },
                child: const Text("Skip, I'll Take The Risk"),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }

   seedPhraseListWidget(
      CreateWalletProvider value, BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: value.mnemonicList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _calculateCrossAxisCount(context),
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
        mainAxisExtent: 35,
      ),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration:  BoxDecoration(
          color: Colors.black12.withOpacity(0.08),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          '${index + 1}. ${value.mnemonicList[index]}',
          style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w500),
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
