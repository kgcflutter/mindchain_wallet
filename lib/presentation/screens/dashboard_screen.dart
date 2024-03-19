import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/account_details_screen.dart';
import 'package:mindchain_wallet/presentation/screens/send_token_screen.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import 'package:mindchain_wallet/widget/custom_popup.dart';
import 'package:mindchain_wallet/widget/gredient_background_bottom.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => customPopUp(
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
                                      const Text("Log Out"),
                                    ],
                                  ),
                                ),
                              ),
                              child: const Icon(
                                Icons.more_vert,
                                size: 25,
                                color: Colors.white,
                              ),
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
                          builder: (context, value, child) =>
                              value.mindBalance.isEmpty
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Row(
                                      children: [
                                        Text(
                                          value.mindBalance,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => value.loadBalance(),
                                          child: const Icon(
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
                              iconData: Icons.arrow_upward, text: "Send"),
                        ),
                        Consumer<AccountDetailsProvider>(
                          builder: (context, value, child) => InkWell(
                            onTap: () {
                              showBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) => SizedBox(
                                  height: 500,
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Your Address To Receive  Funds ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              child: PrettyQrView.data(
                                                data: value.myAddress,
                                                decoration:
                                                     PrettyQrDecoration(
                                                  image:
                                                      PrettyQrDecorationImage(
                                                    image: AssetImage(
                                                        AssetsPath.mindLogoPng),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            // Use Expanded widget to allow the text to take remaining space
                                            Expanded(
                                              child: Text(
                                                value.myAddress,
                                                // Set text alignment to center if needed
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        InkWell(
                                            onTap: () => mnemonicListCopyText(
                                                context, value.myAddress),
                                            child: const GredientBackgroundBtn(
                                              child: Text(
                                                "Copy Address",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                            onTap: () => Share.text('This my Mindchain Wallet Address', value.myAddress, ''),
                                            child: const GredientBackgroundBtn(
                                              child: Text(
                                                "Share",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const IconsBackground(
                                iconData: Icons.arrow_downward,
                                text: "Receive"),
                          ),
                        ),
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
