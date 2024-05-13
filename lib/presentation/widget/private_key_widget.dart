import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/widget/password_checker_popup.dart';

Widget privateKeyBox(
    AccountDetailsProvider value, Size screenSize, BuildContext context) {
  return InkWell(
    onTap: () => value.showMyKey(),
    child: Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.045),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          height: 0.10 * screenSize.height,
          child: Text(
            value.myPrivateKey,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: const TextStyle(fontSize: 12),
            // Set max lines to 3
            overflow: TextOverflow.ellipsis, // Overflow handling
          ),
        ),
        Visibility(
          visible: value.showKey == false,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 80,
              color: Colors.black.withOpacity(0),
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  passwordCheckerPopUp(context);
                },
                icon: const Icon(
                  Icons.visibility_off,
                  size: 40,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
