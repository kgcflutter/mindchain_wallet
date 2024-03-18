import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:provider/provider.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/widget/dashboard_card.dart';
import 'package:mindchain_wallet/widget/icon_background.dart';

class DashboardScreen extends StatelessWidget {
  final String balance;
  final String address;
  final String privateKey;

  const DashboardScreen({
    Key? key,
    required this.balance,
    required this.address,
    required this.privateKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                DashboardCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            Icon(Icons.more_horiz,color: Colors.white,)
                          ],
                        ),
                        const Text(
                          "Mind Chain Wallet",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Type Mind Chain Wallet",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              balance,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                            InkWell(
                              onTap: () => Provider.of<CreateWalletProvider>(
                                context,
                                listen: false,
                              ).checkBalance(privateKey),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: screenWidth * 0.2, // Adjust height as per your need
                    width: double.infinity,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      IconsBackground(iconData: Icons.add, text: "Add Assets"),
                      IconsBackground(iconData: Icons.wallet, text: "Buy MIND"),
                      IconsBackground(iconData: Icons.arrow_forward, text: "Send"),
                      IconsBackground(iconData: Icons.arrow_upward, text: "Receive"),
                      IconsBackground(iconData: Icons.stacked_bar_chart, text: "Stack"),
                    ],),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
