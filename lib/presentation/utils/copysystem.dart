import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void mnemonicListCopyText(BuildContext context, String copyText) {
  Clipboard.setData(ClipboardData(text: copyText),);
  Fluttertoast.showToast(
      msg: "Text copied to clipboard",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.deepPurple,
      textColor: Colors.white,
      fontSize: 16.0
  );
}