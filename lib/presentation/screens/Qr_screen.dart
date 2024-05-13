import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanScreen extends StatelessWidget {
  const QrCodeScanScreen({Key? key}) : super(key: key);

  void load(BuildContext context) {
    SendTokenProvider provider = SendTokenProvider();
    if (provider.addressTEC.text.isNotEmpty) {
      print("Result: ${provider.result}");
      Navigator.pop(context); // Close the screen
    }
  }

  @override
  Widget build(BuildContext context) {
    load(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer<SendTokenProvider>(
          builder: (context, provider, child) => SizedBox(
            height: 250,
            width: 250,
            child: QRView(
              key: provider.qrKey,
              onQRViewCreated: (controller) {
                provider.onQRViewCreated(controller);
                // Handle scan completion here
                // Example: Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
