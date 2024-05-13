import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindchain_wallet/presentation/utils/uri_luncher.dart';
import 'package:mindchain_wallet/presentation/widget/gredient_background_bottom.dart';

class LoginSystemWidget extends StatelessWidget {
  LoginSystemWidget({
    super.key,
    required this.isSmallScreen,
    required this.value,
    required this.hintText,
    required this.inputController,
    required this.password1Controller,
    required this.password2Controller,
    required this.button,
  });

  final bool isSmallScreen;
  String hintText;
  var value;
  TextEditingController inputController;
  TextEditingController password1Controller;
  TextEditingController password2Controller;
  GredientBackgroundBtn button;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: inputController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: hintText,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: const Size(50, 20),
                      padding: const EdgeInsets.symmetric(horizontal: 12)),
                  onPressed: () async {
                    ClipboardData? data =
                        await Clipboard.getData(Clipboard.kTextPlain);
                    inputController.text = data!.text.toString();
                  },
                  child: const Text(
                    "Paste",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text("Set Password"),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: password1Controller,
            decoration: const InputDecoration(hintText: 'New Password'),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: password2Controller,
            decoration: const InputDecoration(hintText: 'Confirm Password'),
          ),
          SizedBox(height: isSmallScreen ? 15 : 30),
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),
              const Text("I read and agree with"),
              TextButton(
                  onPressed: () {
                    launchWeb("https://mindchain.info/privacy-policy");
                  },
                  child: const Text("User Agreement"))
            ],
          ),
          button,
        ],
      ),
    );
  }
}
