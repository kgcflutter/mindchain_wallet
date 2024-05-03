import 'package:flutter/material.dart';

customPopUp(BuildContext context, String title, Widget content) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(child: Text(title)),
      content: content,
      actions: [
        Center(
            child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK"),
        )),
      ],
    ),
  );
}
