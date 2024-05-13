import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import '../provider/account_details_provider.dart';

Widget privateKeyCopyButton(Size screenSize, BuildContext context, AccountDetailsProvider value) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: Colors.orange,
      minimumSize: Size(200, 0.050 * screenSize.height),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        side: BorderSide(color: Color(0xffF38403)),
      ),
    ),
    onPressed: () {
      mnemonicListCopyText(context, value.myPrivateKey);
    },
    child: const Text(
      "Copy private key",
      style: TextStyle(color: Colors.white, fontSize: 12),
    ),
  );
}