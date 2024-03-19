import 'package:flutter/material.dart';
import '../presentation/utils/assets_path.dart';

class GredientBackgroundBtn extends StatelessWidget {
  final Widget child;

  const GredientBackgroundBtn({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AssetsPath.grediantColorImage,
          height: 55,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

