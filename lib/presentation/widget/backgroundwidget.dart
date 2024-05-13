import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset(
        //   AssetsPath.backgroundPNG,
        //   height: double.infinity,
        //   width: double.infinity,
        //   fit: BoxFit.cover,
        // ),

        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white
          ),
        ),

        SafeArea(child: Center(child: child))
      ],
    );
  }
}
