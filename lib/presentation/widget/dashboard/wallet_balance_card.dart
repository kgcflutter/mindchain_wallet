import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/screens/account_details_screen.dart';
import 'package:provider/provider.dart';
import '../../provider/new_assets_token_add_provider.dart';

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
            "MIND WALLET",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 12),
          Consumer<NewAssetsTokenAddProvider>(
            builder: (context, value, child) => Text(
              value.totalDollar,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
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
