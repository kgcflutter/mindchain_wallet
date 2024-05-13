import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/screens/auth/welcome_screen.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:mindchain_wallet/presentation/utils/uri_luncher.dart';
import 'package:mindchain_wallet/presentation/widget/custom_popup.dart';

PopupMenuButton<dynamic> buildPopupMenuButton() {
  return PopupMenuButton(
    surfaceTintColor: Colors.white,
    icon: const Icon(Icons.menu),
    itemBuilder: (context) => [
      PopupMenuItem(
        child: TextButton.icon(
          onPressed: () => launchWeb("https://mindchain.info/"),
          icon: const Icon(Icons.compass_calibration_sharp),
          label: const Text("About Us"),
        ),
      ),
      PopupMenuItem(
        child: TextButton.icon(
          onPressed: () => launchWeb("https://t.me/mindchainMIND"),
          icon: const Icon(Icons.support_agent),
          label: const Text("Support"),
        ),
      ),
      PopupMenuItem(
        child: TextButton.icon(
          onPressed: () => launchWeb("https://mainnet.mindscan.info/"),
          icon: const Icon(Icons.web),
          label: const Text("View On Explorer"),
        ),
      ),
      PopupMenuItem(
        child: TextButton.icon(
          onPressed: () => launchWeb("https://mindchain.info/privacy-policy"),
          icon: const Icon(Icons.privacy_tip_outlined),
          label: const Text("Privacy Policy"),
        ),
      ),
      PopupMenuItem(
        child: TextButton.icon(
          onPressed: () => launchWeb("https://academy.mindchain.info"),
          icon: const Icon(Icons.privacy_tip_outlined),
          label: const Text("Learn Blockchain"),
        ),
      ),
      PopupMenuItem(
        child: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
            customPopUp(
                context,
                "Are You Sure",
                const Text("Log out Your Account"),
                TextButton(
                    onPressed: () {
                      LocalDataBase.removeData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                          (route) => false);
                    },
                    child: const Text("Sure")));
          },
          icon: const Icon(Icons.logout),
          label: const Text("Log Out"),
        ),
      ),
    ],
  );
}
