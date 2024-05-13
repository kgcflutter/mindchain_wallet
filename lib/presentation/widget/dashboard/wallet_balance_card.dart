import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/account_details_screen.dart';
import 'package:provider/provider.dart';

Widget walletCard(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              detailsTextButton(context),
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
          const SizedBox(height: 12),
          Consumer<CreateWalletProvider>(
            builder: (context, value, child) => value.mindBalance.isEmpty
                ? const Text(
              "\$0.000",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            )
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
    },
  );
}

Widget detailsTextButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AccountDetailsScreen(),
        ),
      );
    },
    child: const Row(
      children: [
        Text(
          "Details",
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
        Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 15,
        )
      ],
    ),
  );
}
