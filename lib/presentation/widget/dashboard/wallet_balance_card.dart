import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/screens/account_details_screen.dart';
import 'package:provider/provider.dart';

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
          TextButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  const AccountDetailsScreen(),
                ));
          }, child: const Row(
            children: [
              Text("Details",style: TextStyle(color: Colors.white,fontSize: 10),),
              Icon(Icons.arrow_forward,color: Colors.white,size: 15,)
            ],
          )),
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
            ? const Text("\$0.000",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
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
