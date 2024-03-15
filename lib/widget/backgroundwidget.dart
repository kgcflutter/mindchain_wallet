import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AssetsPath.backgroundPNG,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child)
      ],
    );
  }
}