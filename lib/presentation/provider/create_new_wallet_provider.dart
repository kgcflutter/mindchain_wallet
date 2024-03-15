import 'dart:math';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:http/http.dart' as http;

class CreateWalletProvider extends ChangeNotifier {
  List<String> mnemonicList = [];
  String copyText = '';
  String mindBalance = '';
  final Web3Client ethClient;

  CreateWalletProvider()
      : ethClient =
            Web3Client('https://seednode.mindchain.info/', http.Client());

  Future<void> createWallet() async {
    try {
      mnemonicList.clear();
      copyText = '';
      final mnemonic = bip39.generateMnemonic();
      final privateKey = await getPrivateKey(mnemonic);
      final address = await getPublicKey(privateKey!);
      copyText = mnemonic;
      mnemonicList.addAll(mnemonic.split(" "));
      print('Your new private key: $privateKey');
      print('Your new address: ${address.hex}');
      print('Your mnemonic: $mnemonic');
      print(
          'Please make sure to securely store your private key, address, and mnemonic.');
    } catch (e) {
      print('Error occurred while creating wallet: $e');
    }
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
      return null; // Handle the error according to your app's logic
    }
  }

  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = private.address;
    return address;
  }


  void checkBalance(String myPrivateKey) async {
    Credentials credentials = await getCredentials(myPrivateKey);
    EtherAmount balance = await ethClient.getBalance(credentials.address);
    print('Wallet balance: ${balance.getValueInUnit(EtherUnit.ether)} MIND');
    print(_convertToEth(balance.getInWei));
  }

  Future<Credentials> getCredentials(String privateKey) async {
    String? privateKeys = privateKey;
    if (privateKeys != null) {
      return EthPrivateKey.fromHex(privateKey);
    } else {
      throw Exception('Invalid private key.');
    } }

  void mnemonicListCopyText(BuildContext context) {
    Clipboard.setData(ClipboardData(text: copyText));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Text copied to clipboard'),
    ));
  }

  String _convertToEth(BigInt wei) {
    final eth = (wei / BigInt.from(1 * pow(10, 18))).toStringAsFixed(20);
    mindBalance = eth.toString();
    notifyListeners();
    return '$eth ETH';
  }
}
