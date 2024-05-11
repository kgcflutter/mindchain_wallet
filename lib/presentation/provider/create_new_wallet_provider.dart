import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:http/http.dart' as http;
import '../utils/convert_to_eth.dart';
import '../utils/local_database.dart';

class CreateWalletProvider extends ChangeNotifier {
  TextEditingController checkPhraseController = TextEditingController();
  List<String> mnemonicList = [];
  String copyText = '';
  String mindBalance = '';
  final Web3Client ethClient;
  String errorMessage = '';
  String url = "wss://seednode.mindchain.info/ws";

  CreateWalletProvider()
      : ethClient = Web3Client(
          'https://seednode.mindchain.info/',
          http.Client(),
        );

  void createWallet() async {
    if (mnemonicList.isEmpty) {
      mnemonicList.clear();
      copyText = '';
      errorMessage = '';
      checkPhraseController.text = '';
      final mnemonic = bip39.generateMnemonic();
      copyText = mnemonic;
      mnemonicList.addAll(mnemonic.split(" "));
      notifyListeners();
    }
  }

// Function to get the private key from a mnemonic
  getPrivateKey(String mnemonic) async {
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);
      final child =
          root.derivePath("m/44'/60'/0'/0/0"); // Ethereum derivation path
      final privateKeyBytes = child.privateKey;
      final privateKeyHex = bytesToHex(privateKeyBytes as List<int>);
      return privateKeyHex;
    } catch (e) {
      // Print error if any occurs
      if (kDebugMode) {
        print('Error occurred while deriving private key: $e');
      }
      return null;
    }
  }

// Function to get the public key (address) from a private key
  Future<EthereumAddress> getPublicKey(var privateKey) async {
    final credentials = EthPrivateKey.fromHex(privateKey);
    final address = credentials.address;
    return address;
  }

  Future<void> connectWebSocket(String url, String address) async {
    try {
      final socket = await WebSocket.connect(url);
      if (kDebugMode) {
        print('Connected to WebSocket server');
      }

      socket.done.then((_) async {
        // WebSocket connection is closed, attempt to reconnect after a delay
        await Future.delayed(const Duration(seconds: 5));
        await connectWebSocket(url, address); // Reconnect
      });

      Stream.periodic(const Duration(seconds: 1)).listen((_) {
        final balanceSubscribePayload = json.encode({
          'id': 1,
          'method': 'eth_getBalance',
          'params': [address, 'latest'],
        });
        socket.add(balanceSubscribePayload);
      });

      socket.listen(
        (message) {
          final data = json.decode(message);
          if (data['id'] == 1 && data['result'] != null) {
            final balanceHex = data['result'];
            final balanceInWei =
                BigInt.parse(balanceHex.substring(2), radix: 16);
            mindBalance = convertToEth(balanceInWei);
            notifyListeners();
          }
        },
        onError: (_) {},
        cancelOnError: true,
      );
    } catch (_) {
      // Error occurred while connecting, attempt to reconnect after a delay
      await Future.delayed(const Duration(seconds: 5));
      await connectWebSocket(url, address); // Reconnect
    }
  }

  loadBalance() async {
    mindBalance = '';
    mnemonicList.clear();
    copyText = '';
    errorMessage = '';
    String? myKey = await LocalDataBase.getData("pkey");
    String? myAddressKey = await LocalDataBase.getData("address");
    if (myKey != null && myKey.isNotEmpty) {
      if (kDebugMode) {
        print("right");
      }
      connectWebSocket(url, myAddressKey ?? '');
    } else {
      final privateKey = await getPrivateKey(
        checkPhraseController.text.trim(),
      );
      await getPublicKey(privateKey!);
      final address = await getPublicKey(privateKey!);
      savePrivateKey(privateKey, address.hex);
      connectWebSocket(url, address.hex);
    }
    checkPhraseController.text = '';
  }

  savePrivateKey(String privateKey, address) async {
    LocalDataBase.saveData("pkey", privateKey);
    LocalDataBase.saveData("address", address);
  }
}
