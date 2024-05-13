import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

customPopUp(
    BuildContext context, String title, Widget content, TextButton btn) {
  return showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Center(child: Text(title)),
      content: content,
      actions: [
        btn,
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ],
    ),
  );
}
