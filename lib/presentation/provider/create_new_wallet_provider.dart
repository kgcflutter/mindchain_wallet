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

  void createWallet() async {
    mnemonicList.clear();
    copyText = '';
    errorMessage = '';
    checkPhraseController.text = '';

    // Generate a new mnemonic
    final mnemonic = bip39.generateMnemonic();

    // Set the mnemonic to copyText
    copyText = mnemonic;

    // Split the mnemonic into words and add to mnemonicList
    mnemonicList.addAll(mnemonic.split(" "));

    // Print the generated mnemonic
    print('Your mnemonic: $mnemonic');

    // Notify listeners of any changes
    notifyListeners();
  }

// Function to get the private key from a mnemonic
  Future<String?> getPrivateKey(String mnemonic) async {
    try {
      // Convert mnemonic to seed
      final seed = bip39.mnemonicToSeed(mnemonic);

      // Derive master key from seed
      final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);

      // Encode master key to hexadecimal
      final privateKey = HEX.encode(master.key);

      // Print the private key
      print(privateKey);

      return privateKey;
    } catch (e) {
      // Print error if any occurs
      print('Error occurred while deriving private key: $e');
      return null;
    }
  }

// Function to get the public key (address) from a private key
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    // Convert private key to Ethereum private key object
    final private = EthPrivateKey.fromHex(privateKey);

    // Retrieve the corresponding public address
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




//
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:web3dart/crypto.dart';
// import 'package:web3dart/web3dart.dart';
// import 'package:bip39/bip39.dart' as bip39;
// import 'package:bip32/bip32.dart' as bip32;
//
// void main(List<String> arguments) {
//   final ethClient = Web3Client('https://seednode.mindchain.info/', http.Client());
//   startCli(ethClient);
// }
//
// void startCli(Web3Client ethClient) {
//   print('Welcome to the Dart Ethereum CLI Wallet');
//   print('Please select an option:');
//   print('1. Import wallet using mnemonic');
//   print('2. Create new wallet');
//   print('3. Send ETH');
//   print('4. Check wallet balance');
//   print('5. Login with private key');
//   print('6. Mnemonic To PrivateKey');
//   print('7. Add new token using address');
//
//   String? option = stdin.readLineSync();
//   switch (option) {
//     case '1':
//       importWallet(ethClient);
//       break;
//     case '2':
//       createWallet(ethClient);
//       break;
//     case '3':
//       break;
//     case '4':
//       checkBalance(ethClient);
//       break;
//     case '5':
//       loginWithPrivateKey(ethClient);
//       break;
//     case '6':
//       mnemonicToPrivateKey();
//       break;
//     case '7':
//       break;
//     default:
//       print('Invalid option selected.');
//       break;
//   }
// }
//
// void mnemonicToPrivateKey() {
//   print('Enter your mnemonic phrase:');
//   String? mnemonic = stdin.readLineSync();
//
//   if (mnemonic != null && bip39.validateMnemonic(mnemonic)) {
//     final seed = bip39.mnemonicToSeed(mnemonic);
//     final root = bip32.BIP32.fromSeed(seed);
//     final child = root.derivePath("m/44'/60'/0'/0/0"); // Ethereum derivation path
//     final privateKey = child.privateKey;
//
//     print('Your private key derived from mnemonic: $privateKey');
//     print('Please make sure to securely store your private key, address, and mnemonic.');
//   } else {
//     print('Invalid or empty mnemonic phrase.');
//   }
// }
//
// void importWallet(Web3Client ethClient) {
//   print('Enter your mnemonic phrase:');
//   String? mnemonic = stdin.readLineSync();
//   if (mnemonic != null && bip39.validateMnemonic(mnemonic)) {
//     final seed = bip39.mnemonicToSeed(mnemonic);
//     final root = bip32.BIP32.fromSeed(seed);
//     final child = root.derivePath("m/44'/60'/0'/0/0"); // Ethereum derivation path
//     final privateKey = child.privateKey;
//     final credentials = EthPrivateKey.fromHex(privateKey.toString());
//     final address = credentials.address;
//     print('Wallet imported successfully.');
//     print('Your address: ${address.hex}');
//   } else {
//     print('Invalid mnemonic phrase.');
//   }
// }
//
// void createWallet(Web3Client ethClient) async {
//   print('Generating a new mnemonic...');
//   final mnemonic = bip39.generateMnemonic();
//   final seed = bip39.mnemonicToSeed(mnemonic);
//   final root = bip32.BIP32.fromSeed(seed);
//   final child = root.derivePath("m/44'/60'/0'/0/0"); // Ethereum derivation path
//   final privateKeyBytes = child.privateKey;
//   final privateKeyHex = bytesToHex(privateKeyBytes as List<int>);
//   final credentials = EthPrivateKey.fromHex(privateKeyHex);
//   final address = await credentials.extractAddress();
//
//   print('Your new mnemonic: $mnemonic');
//   print('Your new private key: $privateKeyHex');
//   print('Your new address: ${address.hex.toString().toUpperCase()}');
//   print('Please make sure to securely store your private key, address, and mnemonic.');
// }
//
//
// void checkBalance(Web3Client ethClient) async {
//   Credentials credentials = await getCredentials();
//   EtherAmount balance = await ethClient.getBalance(credentials.address);
//   print('Wallet balance: ${balance.getValueInUnit(EtherUnit.ether)} MIND');
// }
//
// void loginWithPrivateKey(Web3Client ethClient) async {
//   print('Enter your private key:');
//   String? privateKey = stdin.readLineSync();
//   if (privateKey != null) {
//     Credentials credentials = EthPrivateKey.fromHex(privateKey);
//     print('Login successful.');
//   } else {
//     print('Invalid private key.');
//   }
// }
//
// Future<Credentials> getCredentials() async {
//   print('Enter your private key:');
//   String? privateKey = stdin.readLineSync();
//   if (privateKey != null) {
//     return EthPrivateKey.fromHex(privateKey);
//   } else {
//     throw Exception('Invalid private key.');
//   }
// }
//
//
//



