import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/send_token_screen.dart';
import 'package:provider/provider.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/widget/dashboard_card.dart';
import 'package:mindchain_wallet/widget/icon_background.dart';

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
    loadBal();
  }
  loadBal() async {
    Future.delayed(
      const Duration(seconds: 1),
      () => Provider.of<CreateWalletProvider>(context, listen: false)
          .loadBalance(),
    );
  }

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
                            Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            )
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
                        Consumer<CreateWalletProvider>(
                          builder: (context, value, child) =>  value.mindBalance.isEmpty
                              ? const CircularProgressIndicator(color: Colors.white) : Row(
                            children: [
                              Text(value.mindBalance,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ),
                                    ),
                              const InkWell(
                                child: Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: screenWidth * 0.2, // Adjust height as per your need
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const IconsBackground(
                            iconData: Icons.add, text: "Add Assets"),
                        const IconsBackground(
                            iconData: Icons.wallet, text: "Buy MIND"),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SendToken(),
                              )),
                          child: const IconsBackground(
                              iconData: Icons.arrow_forward, text: "Send"),
                        ),
                        const IconsBackground(
                            iconData: Icons.arrow_upward, text: "Receive"),
                        const IconsBackground(
                            iconData: Icons.stacked_bar_chart, text: "Stack"),
                      ],
                    ),
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
