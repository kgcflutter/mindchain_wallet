import 'package:flutter/material.dart';

class DappScreen extends StatelessWidget {
  const DappScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("dApp"),),
      body: const Center(child: Text("Coming Soon"),),
    );
  }
}
