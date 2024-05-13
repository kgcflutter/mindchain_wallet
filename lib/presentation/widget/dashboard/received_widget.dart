import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import 'package:qr_bar_code/code/src/code_generate.dart';
import 'package:qr_bar_code/code/src/code_type.dart';

Widget receivedWidget(AccountDetailsProvider value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SingleChildScrollView(
      child: Column(
          children: [
            const SizedBox(height: 15,),
            const Text(
              "Your Address To Receive Funds",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.width - 250,
              width: MediaQuery.of(context).size.width - 200,
              child: Code(
                data: value.myAddress,
                codeType: CodeType.qrCode(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(21),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  const Text("Receiver"),
                  const SizedBox(height: 5,),
                  Text(
                    value.myAddress,
                    style: const TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: ElevatedButton.icon(
                    onPressed: () => mnemonicListCopyText(context, value.myAddress),
                    icon: const Icon(Icons.copy),
                    label: const Text("Copy"),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton.icon(
                    onPressed: () => Share.share(value.myAddress),
                    icon: const Icon(Icons.share),
                    label: const Text("Share"),
                  )),
                ],
              ),
          ],
        ),
      ),
    );
}
