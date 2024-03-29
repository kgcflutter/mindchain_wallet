import 'dart:convert';
import 'dart:io';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
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
      : ethClient = Web3Client('https://seednode.mindchain.info/', http.Client(),);

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

  // checkBalance(String privateKey) async {
  //   mindBalance = '';
  //   notifyListeners();
  //   Credentials credentials = await getCredentials(privateKey);
  //   EtherAmount balance = await ethClient.getBalance(credentials.address);
  //   mindBalance = convertToEth(balance.getInWei).toString();
  //   convertToEth(balance.getInWei).toString();
  //   notifyListeners();
  // }

  Future<void> connectWebSocket(String url, String address) async {
    try {
      final socket = await WebSocket.connect(url);
      print('Connected to WebSocket server');

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
    String? myKey = await LocalDataBase.getData("pkey");
    String? myAddressKey = await LocalDataBase.getData("address");
    if (myKey != null && myKey.isNotEmpty) {
      print("right");
      connectWebSocket(url, myAddressKey!);
    } else {
      final _privateKey = await getPrivateKey(
        checkPhraseController.text.trim(),
      );
      await getPublicKey(_privateKey!);
      final address = await getPublicKey(_privateKey!);
      savePrivateKey(_privateKey!, address.hex);
      connectWebSocket(url, address.hex!);
    }
  }

  savePrivateKey(String privateKey, address) async {
    LocalDataBase.saveData("pkey", privateKey);
    LocalDataBase.saveData("address", address);
  }
}
