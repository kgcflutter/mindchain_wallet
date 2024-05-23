import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/screens/send_token_screen.dart';
import 'package:mindchain_wallet/presentation/utils/uri_luncher.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/received_widget.dart';
import 'package:provider/provider.dart';
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
                    shape: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
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
            InkWell(
              onTap: () => launchWeb("https://my.mindchainwallet.com/register"),
              child: const IconsBackground(
                iconData: Icons.wallet,
                text: "Buy MIND",
              ),
            ),
            InkWell(
              onTap: () => launchWeb("https://mindchain.info/P2p/index"),
              child: const IconsBackground(
                iconData: Icons.stacked_bar_chart,
                text: "P2P",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
