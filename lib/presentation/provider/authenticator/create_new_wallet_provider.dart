import 'package:flutter/foundation.dart';
import 'package:bip39/bip39.dart' as bip39;

class CreateWalletProvider extends ChangeNotifier {
  List<String> mnemonicList = [];
  String copyText = '';
  void createWallet() async {
    if (mnemonicList.isEmpty) {
      final mnemonic = bip39.generateMnemonic();
      copyText = mnemonic;
      mnemonicList.addAll(mnemonic.split(" "));
      notifyListeners();
    }
  }
}
