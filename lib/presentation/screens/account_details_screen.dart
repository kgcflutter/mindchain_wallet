import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Card(
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(
                      Icons.ac_unit,
                      size: 0.1 * screenSize.width,
                    ),
                     Text(
                      "Account Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 0.06 * screenSize.width),
                    ),
                     Icon(
                      Icons.qr_code_2,
                      size: 0.3 * screenSize.width,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<AccountDetailsProvider>(
                      builder: (context, value, child) => Column(
                        children: [
                          GestureDetector(
                            onTap: () => mnemonicListCopyText(context,value.myAddress),
                            child: value.showKey == false ? Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color(0xffFFE7CB),
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                              height: 0.1 * screenSize.height,
                              child: FittedBox(
                                child: Row(
                                  children: [
                                    Text(value.myAddress),
                                    const Icon(Icons.copy)
                                  ],
                                ),
                              ),
                            ) : Text(""),
                          ),
                           SizedBox(
                            height: 0.03 * screenSize.height,
                          ),
                          GestureDetector(
                            onTap: () => mnemonicListCopyText(context, value.myPrivateKey),
                            child: value.showKey == false ? const Text("") : Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color(0xffFFE7CB),
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                              height: 0.1 * screenSize.height,
                              child: FittedBox(
                                child: Row(
                                  children: [
                                    Text(value.myPrivateKey),
                                    const Icon(Icons.copy),
                                  ],
                                ),
                              ),
                            ),
                          ),
                           SizedBox(
                            height: 0.02 * screenSize.height,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 0.07 * screenSize.height),
                                surfaceTintColor: Colors.transparent,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(color: Color(0xffF38403)),),),
                              onPressed: () {
                                value.showMyKey();
                              },
                              child: const Text("Show Private Key",style: TextStyle(color: Color(0xffF38403),),),)
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
    );
  }
}
