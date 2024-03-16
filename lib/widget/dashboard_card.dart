import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  Widget child;
   DashboardCard({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return                 Container(
      width: double.infinity,
      height: 246,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange, // Start color (top left)
            Colors.deepPurple, // End color (bottom right)
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
