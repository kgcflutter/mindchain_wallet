import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/dashboard_screen.dart';
import '../provider/authenticator/sign_in.dart';
import 'auth/login_system_widget.dart';
import 'gredient_background_bottom.dart';

Widget buildLoginTabBar(
    bool isSmallScreen,
    CreateWalletProvider value,
    TextEditingController checkPhraseController,
    checkPrivateKeyController,
    BuildContext context) {
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
            button: loginSeedPhraseButton(context, checkPhraseController),
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

GredientBackgroundBtn loginSeedPhraseButton(
    BuildContext context, TextEditingController checkPhraseController) {
  return GredientBackgroundBtn(
    onTap: () async {
      showDialog(
        useSafeArea: true,
        barrierDismissible: false,
        context: context,
        builder: (context) => const Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          backgroundColor: Colors.white,
          child: SizedBox(
              height: 80,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CupertinoActivityIndicator(),
                  ),
                  Text("Loading"),
                ],
              )),
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 100),
        () async =>
            await SignInSystem.importWallet(checkPhraseController.text).then(
          (value) {
            if (value == true) {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                  (route) => false);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      );
    },
    child: const Text("Submit"),
  );
}
