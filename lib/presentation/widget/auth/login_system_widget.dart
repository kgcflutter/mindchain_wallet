import 'package:flutter/material.dart';
import 'package:mindchain_wallet/conts/strings.dart';
import 'package:mindchain_wallet/presentation/utils/text_style.dart';
import 'package:mindchain_wallet/presentation/widget/gredient_background_bottom.dart';


class LoginSystemWidget extends StatelessWidget {
  LoginSystemWidget({
    super.key,
    required this.isSmallScreen,
    required this.value,
    required this.hintText,
    required this.inputController,
    required this.button,
  });

  final bool isSmallScreen;
  String hintText;
  var value;
  TextEditingController inputController;
  GredientBackgroundBtn button;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            hintText,
            style: TextStyler().textHeadingStyle,
          ),
          SizedBox(height: isSmallScreen ? 12 : 20),
          // Adjust spacing based on screen size
          const Text(AllStrings.saveTheParseDes),
          SizedBox(height: isSmallScreen ? 8 : 10),
          SizedBox(height: isSmallScreen ? 16 : 20),
          TextField(
            controller: inputController,
            maxLines: 3,
            decoration:  InputDecoration(
              hintStyle: const TextStyle(fontSize: 13),
              hintText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
            ),
          ),
          SizedBox(height: isSmallScreen ? 32 : 40),
          button,
        ],
      ),
    );
  }
}