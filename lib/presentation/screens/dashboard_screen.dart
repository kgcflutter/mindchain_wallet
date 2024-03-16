import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/widget/dashboard_card.dart';
import 'package:provider/provider.dart';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      InkWell(
                        onTap: () => mnemonicListCopyText(context,address),
                        child: FittedBox(
                          child: Row(
                            children: [
                              const Text(
                                "Address:",
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${address.split(address[15])[0]}**',
                                    maxLines: 1,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                    size: 15,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => mnemonicListCopyText(context,privateKey),
                        child: FittedBox(
                          child: Row(
                            children: [
                              const Text(
                                "Private Key:",
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${privateKey.split(privateKey[20])[0]}**',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                    size: 15,
                                  )
                                ],
                              )
                            ],
                          ),
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
                                      listen: false)
                                  .checkBalance(privateKey),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ],
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
