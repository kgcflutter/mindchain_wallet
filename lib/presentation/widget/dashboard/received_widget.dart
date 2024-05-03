import 'package:flutter/material.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import 'package:qr_bar_code/code/src/code_generate.dart';
import 'package:qr_bar_code/code/src/code_type.dart';
import '../gredient_background_bottom.dart';

Widget receivedWidget(AccountDetailsProvider value, BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Your Address To Receive Funds",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.width - 200,
            width: MediaQuery.of(context).size.width - 200,
            child: Code(
              data: value.myAddress,
              codeType: CodeType.qrCode(),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            value.myAddress,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 35),
          InkWell(
            onTap: () => mnemonicListCopyText(context, value.myAddress),
            child: const GredientBackgroundBtn(
              child: Text(
                "Copy Address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () => Share.text(
              'This my Mindchain Wallet Address',
              value.myAddress,
              '',
            ),
            child: const GredientBackgroundBtn(
              child: Text(
                "Share",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

