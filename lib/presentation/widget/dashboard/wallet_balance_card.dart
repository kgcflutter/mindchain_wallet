import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:provider/provider.dart';
import 'acount_info_menu_popup.dart';

Column walletCard(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "",
          ),
          GestureDetector(
            onTap: () => myCustomPopUp(context),
            child: const Icon(
              Icons.more_vert,
              size: 25,
              color: Colors.white,
            ),
          ),
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
        builder: (context, value, child) => value.mindBalance.isEmpty
            ? const Text("0.000 MIND",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ))
            : Text(
                value.mindBalance,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
      ),
    ],
  );
}
