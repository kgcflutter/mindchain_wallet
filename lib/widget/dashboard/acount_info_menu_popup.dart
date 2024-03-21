import 'package:flutter/material.dart';
import '../../presentation/utils/local_database.dart';
import '../../presentation/screens/account_details_screen.dart';
import '../../presentation/screens/auth/welcome_screen.dart';
import '../custom_popup.dart';

myCustomPopUp(BuildContext context) {
  customPopUp(
    context,
    "Account Info",
    SizedBox(
      height: 140,
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const AccountDetailsScreen(),
                    ));
              },
              child: const Text("Account Details")),
          const Divider(),
          const Text("View On Explorer"),
          const Divider(),
          const Text("Support"),
          const Divider(),
          GestureDetector(
              onTap: () {
                LocalDataBase.removeData();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const WelcomeScreen(),
                    ),
                        (route) => false);
              },
              child: const Text("Log Out")),
        ],
      ),
    ),
  );
}
