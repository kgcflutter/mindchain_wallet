import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;

  const DashboardCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.2;

    return Container(
      width: double.infinity,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        image:  DecorationImage(
          image: AssetImage(AssetsPath.walletBG),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
