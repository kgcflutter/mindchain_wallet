import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/assets_and_trx_tapbar.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/dashboard_card.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/send_receive_assets_row.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/wallet_balance_card.dart';
import 'package:mindchain_wallet/presentation/widget/popup_menu_widget.dart';

import 'new_assets_add_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Home"),
        centerTitle: true,
        leading: buildPopupMenuButton(),
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
    );
  }
}
