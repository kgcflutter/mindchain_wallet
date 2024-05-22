import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/MainBottomNavBarScreen.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import '../provider/authenticator/sign_in.dart';
import 'auth/login_system_widget.dart';
import 'gredient_background_bottom.dart';

Widget buildLoginTabBar(
    bool isSmallScreen,
    CreateWalletProvider value,
    TextEditingController checkPhraseController,
    TextEditingController password1controller,
    TextEditingController password2controller,
    checkPrivateKeyController,
    BuildContext context) {
  return Column(
    children: <Widget>[
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          height: 45,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.grey.shade400.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const TabBar(
            indicatorPadding: EdgeInsetsDirectional.all(2),
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            tabs: [
              Tab(text: 'Seed Phrase'),
              Tab(text: 'Private Key'),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 600,
        child: TabBarView(children: [
          LoginSystemWidget(
            isSmallScreen: isSmallScreen,
            value: value,
            hintText: 'Enter Your Seed Phrase',
            inputController: checkPhraseController,
            button: loginSeedPhraseButton(context, checkPhraseController,
                password1controller, password2controller),
            password1Controller: password1controller,
            password2Controller: password2controller,
          ),
          LoginSystemWidget(
            isSmallScreen: isSmallScreen,
            value: value,
            hintText: "Enter Your Private Key Then Submit",
            inputController: checkPrivateKeyController,
            button: GredientBackgroundBtn(
              onTap: () async {
                if (password1controller.text.length > 7 &&
                    password2controller.text.length > 7 &&
                    password2controller.text == password1controller.text) {
                  await LocalDataBase.saveData(
                      "pass", password1controller.text);
                  await LocalDataBase.saveData(
                      "pass", password2controller.text);
                  await SignInSystem.loginWithPrivateKey(
                          checkPrivateKeyController.text)
                      .then(
                    (value) {
                      if (value == true) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MainBottomNavBarScreen(),
                            ),
                            (route) => false);
                      }
                    },
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: "Something Wrong",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: const Text(
                "Import Wallet",
              ),
            ),
            password1Controller: password1controller,
            password2Controller: password2controller,
          ),
        ]),
      )
    ],
  );
}

GredientBackgroundBtn loginSeedPhraseButton(BuildContext context,
    TextEditingController checkPhraseController, TextEditingController pass1, TextEditingController pass2) {
  return GredientBackgroundBtn(
    onTap: () async {
      if (pass1.text.length > 7 && pass2.text.length > 7 && pass1.text == pass2.text) {
        await LocalDataBase.saveData("pass", pass1.text);
        await LocalDataBase.saveData("pass", pass2.text);
        buildshowDialog(context);
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
                      builder: (context) => const MainBottomNavBarScreen(),
                    ),
                    (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        );
      }else{
        Fluttertoast.showToast(
            msg: "Please Check password filled",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

      }
    },
    child: const Text("Import Wallet"),
  );
}

Future<dynamic> buildshowDialog(BuildContext context) {
  return showDialog(
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
}
