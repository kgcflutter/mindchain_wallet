import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/account_details_screen.dart';
import 'package:mindchain_wallet/presentation/screens/auth/welcome_screen.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:mindchain_wallet/presentation/utils/uri_luncher.dart';
import 'package:provider/provider.dart';
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
           InkWell(
            onTap: () => launchWeb("https://mainnet.mindscan.info/"),
              child: const Text("View On Explorer")),
          const Divider(),
          GestureDetector(
            onTap: () => launchWeb("https://t.me/mindchainMIND"),
              child: const Text("Support"),),
          const Divider(),
          GestureDetector(
              onTap: () {
                Provider.of<CreateWalletProvider>(context,listen: false).mindBalance = '';
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
