import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/screens/auth/splash_screen.dart';

class MindWallet extends StatelessWidget {
  const MindWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: const Color(0xffF5F5F5),
                minimumSize: const Size(double.maxFinite, 58),
                side: const BorderSide(
                  color: Colors.white,
                ))),
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
