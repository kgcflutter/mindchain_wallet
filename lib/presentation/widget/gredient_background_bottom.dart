import 'package:flutter/material.dart';

class GredientBackgroundBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const GredientBackgroundBtn({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: 58,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFEDE7F6), Color(0xFFFFCC80)],
          ),
        ),
        child: child,
      ),
    );
  }
}
