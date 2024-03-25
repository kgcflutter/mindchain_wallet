import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:mindchain_wallet/presentation/screens/dashboard_screen.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

class TransActionSuccessScreen extends StatelessWidget {
  String tokenName;
  String amount;

  TransActionSuccessScreen(
      {super.key, required this.tokenName, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWidget(
      child: SafeArea(
        child: Consumer<SendTokenProvider>(
          builder: (context, value, child) => SizedBox(
            height: 500,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                surfaceTintColor: Colors.transparent,
                child: value.trxResult.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetsPath.donePng,
                            height: 70,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              children: [
                                const Text("Amount:"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '$amount $tokenName',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () =>
                                mnemonicListCopyText(context, value.trxResult),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text("Transaction ID: ${value.trxResult}"),
                            ),
                          ),
                          TextButton(
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardScreen(),
                                  ),
                                  (route) => false),
                              child: const Text("Go To Dashboard"))
                        ],
                      )
                    : value.trxError.isEmpty
                        ? Column(
                            children: [
                              Lottie.asset(AssetsPath.transactionJson),
                              const Text("Please Wait For Transaction"),
                            ],
                          )
                        : Column(
                            children: [
                              Text(value.trxError),
                              TextButton(
                                  onPressed: () => Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DashboardScreen(),
                                      ),
                                      (route) => false),
                                  child: const Text("Back To Dashboard"))
                            ],
                          ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
