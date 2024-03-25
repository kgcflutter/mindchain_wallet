import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:web3dart/web3dart.dart';


class NewAssetsTokenAddProvider extends ChangeNotifier {

  List allTokenList = [
    {"contract ": "0xaC264f337b2780b9fd277cd9C9B2149B43F87904", "name": "MIND-Chain USD", "symbol": "MUSD", "Decimals": "18"  },
    {"contract ": "0x75E218790B76654A5EdA1D0797B46cBC709136b0", "name": "Perry MIND", "symbol": "PMIND", "Decimals": "18"  },
    {"contract ": "0x94E6F64f9a00bE3a7B353f55b303DC5eb0C9C396", "name": "Wrapped MIND", "symbol": "WMIND", "Decimals": "18"  },
  ];

}


class Token {
  String name;
  String symbol;
  String contractAddress;
  int decimals;
  String abi;

  Token(this.name, this.symbol, this.contractAddress, this.decimals, this.abi);
}

List<Token> tokens = [];



Future<Credentials> getCredentials() async {
  print('Enter your private key:');
  String? privateKey = stdin.readLineSync();
  if (privateKey != null) {
    return EthPrivateKey.fromHex(privateKey);
  } else {
    throw Exception('Invalid private key.');
  }
}

Future<void> addNewToken(Web3Client ethClient) async {
  print('Adding new token...');
  print('Enter the contract address of the token:');
  String? contractAddress = stdin.readLineSync();

  if (contractAddress != null) {
    try {
      Token token = await fetchTokenInfo(ethClient, contractAddress);
      tokens.add(token);
      print('Token added successfully: ${token.name} (${token.symbol})');
      sendTokenTransactionOption(ethClient);
    } catch (e) {
      print('Error adding token: $e');
    }
  } else {
    print('Invalid contract address.');
  }
}

Future<Token> fetchTokenInfo(Web3Client ethClient, String contractAddress) async {
  DeployedContract contract = DeployedContract(
    ContractAbi.fromJson(tokenAbi, 'Token'), // Use token ABI
    EthereumAddress.fromHex(contractAddress),
  );

  final name = await ethClient.call(
    contract: contract,
    function: contract.function('name'),
    params: [],
  );

  final symbol = await ethClient.call(
    contract: contract,
    function: contract.function('symbol'),
    params: [],
  );

  // Assuming decimals is always 18 for this token
  const decimals = 18;

  // Convert BigInt values to int using their `toInt()` method
  return Token(name[0] as String, symbol[0] as String, contractAddress, decimals, tokenAbi);
}

Future<void> sendTokenTransactionOption(Web3Client ethClient) async { // Renamed the function here
  print('Enter the recipient address:');
  String? recipientAddress = stdin.readLineSync();
  print('Enter the amount to send:');
  String? amount = stdin.readLineSync();

  if (recipientAddress != null && amount != null) {
    try {
      BigInt parsedAmount = BigInt.parse(amount);
      // Assuming you have selected a token from your list of added tokens
      Token selectedToken = tokens.first; // You might want to add logic to select a token from the list
      await sendTokenTransaction(ethClient, selectedToken, recipientAddress, parsedAmount);
    } catch (e) {
      print('Invalid amount entered. Please enter a valid number.');
    }
  } else {
    print('Invalid recipient address or amount.');
  }
}

Future<void> sendTokenTransaction(
    Web3Client ethClient, Token token, String receiver, BigInt amount) async {
  var chainId = await ethClient.getChainId();
  print('Sending token transaction...');
  Credentials credentials = await getCredentials();

  DeployedContract contract = DeployedContract(
    ContractAbi.fromJson(token.abi, 'Token'),
    EthereumAddress.fromHex(token.contractAddress),
  );

  final response = await ethClient.sendTransaction(
    credentials,
    Transaction.callContract(
      contract: contract,
      function: contract.function('transfer'),
      parameters: [EthereumAddress.fromHex(receiver), amount],
      gasPrice: await ethClient.getGasPrice(),
      maxGas: 100000,
    ),
    chainId: int.parse(chainId.toString()),
  );

  if (response != null) {
    print('Token transaction sent! Hash: $response');
  } else {
    print('Failed to send token transaction.');
  }
}

String bytesToHex(List<int> bytes) {
  return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

// Replace this with actual ABI of ERC20 token
const String tokenAbi = '[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"}]';
