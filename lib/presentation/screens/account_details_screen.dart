import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AccountDetailsProvider>(context).loadPrivateKeyAddress();
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BackgroundWidget(
        child: SizedBox(
          height: screenSize.height * 0.65,
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.05),
            child: Card(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetsPath.mindLogoPng,
                        height: screenSize.height * 0.09,
                      ),
                      Text(
                        "Account Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 0.06 * screenSize.width),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<AccountDetailsProvider>(
                        builder: (context, value, child) => Column(
                          children: [
                            GestureDetector(
                              onTap: () => mnemonicListCopyText(
                                  context, value.myAddress),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration:  BoxDecoration(
                                    color: Colors.green.shade200,
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(20))),
                                height: 0.12 * screenSize.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      value.myAddress,
                                      textAlign: TextAlign.center,
                                      maxLines: 3, // Set max lines to 3
                                      overflow: TextOverflow
                                          .ellipsis, // Overflow handling
                                    ),
                                    const Icon(Icons.copy)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.01 * screenSize.height,
                            ),
                            GestureDetector(
                              onTap: () => mnemonicListCopyText(
                                  context, value.myPrivateKey),
                              child: value.showKey == false ? const Text("") : Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration:  BoxDecoration(
                                    color: Colors.red.shade200,
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(20))),
                                height: 0.15 * screenSize.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      value.myPrivateKey,
                                      textAlign: TextAlign.center,
                                      maxLines: 3, // Set max lines to 3
                                      overflow: TextOverflow
                                          .ellipsis, // Overflow handling
                                    ),
                                    const Icon(Icons.copy)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.02 * screenSize.height,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    double.infinity, 0.07 * screenSize.height),
                                surfaceTintColor: Colors.transparent,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(color: Color(0xffF38403)),
                                ),
                              ),
                              onPressed: () {
                                value.showMyKey();
                              },
                              child: Text(
                                value.showKey == false ? "Show Private Key" : "Hide Private Key",
                                style: const TextStyle(
                                  color: Color(0xffF38403),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
