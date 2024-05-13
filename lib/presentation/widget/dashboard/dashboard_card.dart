import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;

  const DashboardCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.20;
    return Container(
      width: double.infinity,
      height: cardHeight,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xffFF971D), Color(0xff290059)],
            begin: AlignmentDirectional(0.7, BorderSide.strokeAlignCenter),
            end: AlignmentDirectional(BorderSide.strokeAlignInside, 1.6)),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: child,
    );
  }
}
