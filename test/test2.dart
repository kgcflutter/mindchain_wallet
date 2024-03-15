import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;

void main(List<String> arguments) {
  final ethClient =
  Web3Client('https://seednode.mindchain.info/', http.Client(),);

  startCli(ethClient);
}

void startCli(Web3Client ethClient) {
  print('Welcome to the Dart Ethereum CLI Wallet');
  print('Please select an option:');
  print('1. Import wallet using private key');
  print('2. Create new wallet');
  print('3. Send ETH');
  print('4. Check wallet balance');
  print('5. Login with private key');

  String? option = stdin.readLineSync();
  switch (option) {
    case '1':
      importWallet(ethClient);
      break;
    case '2':
      createWallet(ethClient);
      break;
    case '3':
      sendEth(ethClient);
      break;
    case '4':
      checkBalance(ethClient);
      break;
    case '5':
      loginWithPrivateKey(ethClient);
      break;
    default:
      print('Invalid option selected.');
      break;
  }
}

void importWallet(Web3Client ethClient) {
  print('Enter your private key:');
  String? privateKey = stdin.readLineSync();
  if (privateKey != null) {
    Credentials credentials = EthPrivateKey.fromHex(privateKey);
    print('Wallet imported successfully.');
  } else {
    print('Invalid private key.');
  }
}

void createWallet(Web3Client ethClient) async {
  final rng = Random.secure();
  final privateKeyBytes = List.generate(32, (index) => rng.nextInt(256));
  final privateKeyHex = bytesToHex(privateKeyBytes);

  Credentials credentials = EthPrivateKey.fromHex(privateKeyHex);
  EthereumAddress address = await credentials.extractAddress();

  String mnemonic = bip39.generateMnemonic();

  print('Your new private key: $privateKeyHex');
  print('Your new address: ${address.hex}');
  print('Your mnemonic: $mnemonic');
  print(
      'Please make sure to securely store your private key, address, and mnemonic.');
}

Future<void> sendEth(Web3Client ethClient) async {
  print('Enter the recipient address:');
  String? recipientAddress = stdin.readLineSync();
  print('Enter the amount to send:');
  String? amount = stdin.readLineSync();
  if (recipientAddress != null && amount != null) {
    try {
      BigInt parsedAmount = BigInt.parse(amount);
      EtherAmount txValue = EtherAmount.inWei(parsedAmount);
      await sendTransaction(ethClient, recipientAddress, txValue);
    } catch (e) {
      print('Invalid amount entered. Please enter a valid number.');
    }
  } else {
    print('Invalid recipient address or amount.');
  }
}


void checkBalance(Web3Client ethClient) async {
  Credentials credentials = await getCredentials();
  EtherAmount balance = await ethClient.getBalance(credentials.address);
  print('Wallet balance: ${balance.getValueInUnit(EtherUnit.ether)} MIND');
}

void loginWithPrivateKey(Web3Client ethClient) async {
  print('Enter your private key:');
  String? privateKey = stdin.readLineSync();
  if (privateKey != null) {
    Credentials credentials = EthPrivateKey.fromHex(privateKey);
    // You may want to check the balance or perform other operations with the credentials
    print('Login successful.');
  } else {
    print('Invalid private key.');
  }
}

Future<Credentials> getCredentials() async {
  print('Enter your private key:');
  String? privateKey = stdin.readLineSync();
  if (privateKey != null) {
    return EthPrivateKey.fromHex(privateKey);
  } else {
    throw Exception('Invalid private key.');
  }


}

Future<void> sendTransaction(Web3Client ethClient, String receiver, EtherAmount txValue) async {
  var chainId = await ethClient.getChainId();
  print('Sending transaction...');
  Credentials credentials = await getCredentials();
  EtherAmount gasPrice = await ethClient.getGasPrice();

  Transaction transaction = Transaction(
    to: EthereumAddress.fromHex(receiver),
    gasPrice: gasPrice,
    maxGas: 100000, // You can adjust gas limit as needed
    value: txValue,
  );

  final response = await ethClient.sendTransaction(credentials, transaction, chainId: int.parse(chainId.toString()) );

  if (response != null) {
    print('Transaction sent! Hash: ${response}');
  } else {
    print('Failed to send transaction.');
  }
}
