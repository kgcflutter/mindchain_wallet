import 'dart:math';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hex/hex.dart';
import 'package:mindchain_wallet/presentation/screens/dashboard_screen.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:http/http.dart' as http;

class CreateWalletProvider extends ChangeNotifier {
  TextEditingController checkPhraseController = TextEditingController();
  List<String> mnemonicList = [];
  String copyText = '';
  String mindBalance = '';
  final Web3Client ethClient;
  String errorMessage = '';

  CreateWalletProvider()
      : ethClient = Web3Client(
          'https://seednode.mindchain.info/',
          http.Client(),
        );

  createWallet() async {
    mnemonicList.clear();
    copyText = '';
    errorMessage = '';
    checkPhraseController.text = '';
    final mnemonic = bip39.generateMnemonic();
    //final privateKey = await getPrivateKey(mnemonic);
    //final address = await getPublicKey(privateKey!);
    copyText = mnemonic;
    //myPrivateKey = privateKey;
    //   = address.hex;
    //mindBalance = await checkBalance(privateKey);
    mnemonicList.addAll(mnemonic.split(" "));
    //print('Your new private key: $privateKey');
    //print('Your new address: ${address.hex}');
    print('Your mnemonic: $mnemonic');
    notifyListeners();
  }

  Future<String?> getPrivateKey(String mnemonic) async {
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
      final privateKey = HEX.encode(master.key);
      print(privateKey);
      return privateKey;
    } catch (e) {
      print('Error occurred while deriving private key: $e');
      return null;
    }
  }

  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = private.address;
    return address;
  }

  Future<String> checkBalance(String privateKey) async {
    Credentials credentials = await getCredentials(privateKey);
    EtherAmount balance = await ethClient.getBalance(credentials.address);
    print('Wallet balance: ${balance.getValueInUnit(EtherUnit.ether)} MIND');
    print(convertToEth(balance.getInWei));
    return convertToEth(balance.getInWei).toString();
  }

  Future<Credentials> getCredentials(String privateKey) async {
    String? privateKeys = privateKey;
    if (privateKeys != null) {
      return EthPrivateKey.fromHex(privateKey);
    } else {
      throw Exception('Invalid private key.');
    }
  }

  checkPhraseBottom(BuildContext context) async {
    if (checkPhraseController.text.length > 20) {
      final pKey = await getPrivateKey(checkPhraseController.text.trim());
      final address = await getPublicKey(pKey!);
      final publicKey = address.hex;
      final bal = await checkBalance(pKey!);
      print(publicKey);
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(
                balance: bal, address: publicKey, privateKey: pKey),
          ),
        );
      }
      notifyListeners();
    } else {
      errorMessage = "Give Valid Data";
    }
    notifyListeners();
  }

  String convertToEth(BigInt wei) {
    final eth = (wei / BigInt.from(1 * pow(10, 18))).toStringAsFixed(4);
    mindBalance = eth.toString();
    notifyListeners();
    return '$eth MIND';
  }
}
