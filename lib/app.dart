import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/screens/auth/splash_screen.dart';

class MindWallet extends StatelessWidget {
  const MindWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide(
              color: Color(0xffC1C1C1),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
