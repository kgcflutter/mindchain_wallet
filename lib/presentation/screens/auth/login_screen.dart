import 'package:flutter/material.dart';
import 'package:mindchain_wallet/conts/strings.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/utils/text_style.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BackgroundWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Consumer<CreateWalletProvider>(builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login With Phrase",
                  style: TextStyler().textHeadingStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(AllStrings.saveTheParseDes),
                const SizedBox(
                  height: 10,
                ),
               value.errorMessage !=null?  Text(value.errorMessage) : const Text(''),
                TextField(
                  controller: value.checkPhraseController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Post Your Phrase',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      side: const BorderSide(color: Colors.white),
                      maximumSize: const Size(double.infinity, 45),
                      backgroundColor: const Color(0xffF5F5F5),
                    ),
                    onPressed: () {
                      value.checkPhraseBottom(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),),
          ),
        ),
      ),
    );
  }
}
