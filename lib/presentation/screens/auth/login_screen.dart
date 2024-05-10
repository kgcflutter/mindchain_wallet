import 'package:flutter/material.dart';
import 'package:mindchain_wallet/conts/strings.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/dashboard_screen.dart';
import 'package:mindchain_wallet/presentation/utils/text_style.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/presentation/widget/gredient_background_bottom.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen =
        screenSize.width < 600;

    return Scaffold(
      body: Center(
        child: BackgroundWidget(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen
                  ? 12.0
                  : 24.0, // Adjust padding based on screen size
            ),
            child: Consumer<CreateWalletProvider>(
              builder: (context, value, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login With Phrase",
                    style: TextStyler().textHeadingStyle,
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 20),
                  // Adjust spacing based on screen size
                  const Text(AllStrings.saveTheParseDes),
                  SizedBox(height: isSmallScreen ? 8 : 10),
                  if (value.errorMessage.isNotEmpty) Text(value.errorMessage),
                  SizedBox(height: isSmallScreen ? 16 : 20),
                  TextField(
                    controller: value.checkPhraseController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Post Your Phrase',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 32 : 40),
                  GredientBackgroundBtn(
                      onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
                          ),
                          (route) => false),
                      child: const Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
