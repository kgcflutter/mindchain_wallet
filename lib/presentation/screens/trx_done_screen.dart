import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:provider/provider.dart';

class TrxDoneScreen extends StatelessWidget {
  const TrxDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.done,color: Colors.green,),
                const Text("congratulations",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 10,
                ),
                Consumer<SendTokenProvider>(
                  builder: (context, value, child) => Text(value.trxResult),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
