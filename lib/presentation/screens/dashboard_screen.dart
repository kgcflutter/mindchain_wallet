import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/screens/auth/welcome_screen.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:mindchain_wallet/presentation/utils/uri_luncher.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/presentation/widget/custom_popup.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/assets_and_trx_tapbar.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/dashboard_card.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/send_receive_assets_row.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/wallet_balance_card.dart';

import 'new_assets_add_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          leading: PopupMenuButton(
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
                  onPressed: () =>
                      launchWeb("https://mindchain.info/privacy-policy"),
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
                    customPopUp(context, "Are You Sure",
                        const Text("Log out Your Accout"),
                      TextButton(onPressed: () {
                        LocalDataBase.removeData();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                                (route) => false);
                      }, child: const Text("Sure"))
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Log Out"),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewAssetsAddScreen(),
                      ),
                    ),
                icon: const Icon(Icons.add)),
            const SizedBox(
              width: 5,
            )
          ],
        ),
        body: BackgroundWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                DashboardCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: walletCard(context),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SendReceiveAssetsRow(screenWidth: screenWidth),
                const SizedBox(
                  height: 5,
                ),
                const AssetsAndTrxTapbar(),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
