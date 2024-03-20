import 'package:flutter/material.dart';
import 'package:mindchain_wallet/widget/dashboard/received_widget.dart';
import 'package:provider/provider.dart';

import '../../presentation/provider/account_details_provider.dart';
import '../../presentation/screens/send_token_screen.dart';
import 'icon_background.dart';

class SendReceiveAssetsRow extends StatelessWidget {
  const SendReceiveAssetsRow({
    Key? key,
    required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: screenWidth * 0.2, // Adjust height as per your need
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const IconsBackground(
              iconData: Icons.add,
              text: "Add Assets",
            ),
            const IconsBackground(
              iconData: Icons.wallet,
              text: "Buy MIND",
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SendToken(),
                ),
              ),
              child: const IconsBackground(
                iconData: Icons.arrow_upward,
                text: "Send",
              ),
            ),
            Consumer<AccountDetailsProvider>(
              builder: (context, value, child) => InkWell(
                onTap: () {
                  value.loadPrivateKeyAddress();
                  showBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => receivedWidget(value, context),
                  );
                },
                child: const IconsBackground(
                  iconData: Icons.arrow_downward,
                  text: "Receive",
                ),
              ),
            ),
            const IconsBackground(
              iconData: Icons.stacked_bar_chart,
              text: "Stack",
            ),
          ],
        ),
      ),
    );
  }
}
