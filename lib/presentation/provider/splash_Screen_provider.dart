import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/local_database.dart';
import 'package:mindchain_wallet/presentation/screens/auth/welcome_screen.dart';
import 'package:mindchain_wallet/presentation/screens/dashboard_screen.dart';

class SplashScreenProvider extends ChangeNotifier {
  runApp(BuildContext context) async {
    String? data = await LocalDataBase.getData("pkey");
    Future.delayed(
      const Duration(seconds: 2),
          () {
        if (data == null || data.isEmpty) { // Check if data is null or empty
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ),
          );
        }
      },
    );
  }
}
