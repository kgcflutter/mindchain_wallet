import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:provider/provider.dart';

void passwordCheckerPopUp(BuildContext context) {
  TextEditingController controller = TextEditingController();
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text("Verify password"),
      content: CupertinoTextField(
        padding: const EdgeInsets.all(10),
        controller: controller,
        placeholder: 'Please enter your wallet password',
        placeholderStyle: const TextStyle(fontSize: 12,
        fontWeight: FontWeight.w300),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        CupertinoDialogAction(
          onPressed: () async {
            print(await LocalDataBase.getData("pass"));
            if (await LocalDataBase.getData("pass") == controller.text) {
              if (context.mounted) {
                Provider.of<AccountDetailsProvider>(context, listen: false)
                    .showMyKey();
                controller.text = '';
                Navigator.pop(context);
              }
            } else {
              Fluttertoast.showToast(
                  msg: "Password Incorrect",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          child: const Text(
            "Confirm",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
