import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void mnemonicListCopyText(BuildContext context, String copyText) {
  Clipboard.setData(ClipboardData(text: copyText));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Text copied to clipboard'),
    ),
  );
}