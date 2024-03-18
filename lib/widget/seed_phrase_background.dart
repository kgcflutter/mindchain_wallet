import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';

class  SeedPhraseBackground extends StatelessWidget {
  const SeedPhraseBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image.asset(
            AssetsPath.seedPhrasePng,
            height: 210,
          ),
          SafeArea(child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),),
        ],
      ),
    );
  }
}