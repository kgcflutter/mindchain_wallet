import 'package:flutter/cupertino.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import '../local_database.dart';

class SendTokenProvider extends ChangeNotifier {

  TextEditingController addressTEC = TextEditingController();
  TextEditingController amountTEC = TextEditingController();

  final Web3Client ethClient;
  String trxResult = '';

  SendTokenProvider()
      : ethClient = Web3Client(
          'https://seednode.mindchain.info/',
          http.Client(),
        );

  Future<void> sendEth() async {
    //print('Enter the recipient address:');
    String? recipientAddress = addressTEC.text;
    print('Enter the amount to send:');
    String? amount = amountTEC.text;
    if (recipientAddress != null && amount != null) {
      print(amount);
      try {
        // Convert the amount to Ether and adjust precision
        BigInt parsedAmount = BigInt.parse(amount);
        EtherAmount ethAmount =
            EtherAmount.fromBigInt(EtherUnit.ether, parsedAmount);

        // Sending transaction
        await _sendTransaction(ethClient, recipientAddress, ethAmount);
      } catch (e) {
        print('Invalid amount entered. Please enter a valid number.');
      }
    } else {
      print('Invalid recipient address or amount.');
    }
  }

  Future<void> _sendTransaction(
      Web3Client ethClient, String receiver, EtherAmount txValue) async {
    var chainId = await ethClient.getChainId();
    print('Sending transaction...');
    trxResult = 'Sending transaction...';
    notifyListeners();
    Credentials credentials = await _getCredentials();
    EtherAmount gasPrice = await ethClient.getGasPrice();

    Transaction transaction = Transaction(
      to: EthereumAddress.fromHex(receiver),
      gasPrice: gasPrice,
      maxGas: 100000, // You can adjust gas limit as needed
      value: txValue,
    );

    final response = await ethClient.sendTransaction(credentials, transaction,
        chainId: int.parse(chainId.toString()));

    if (response != null) {
      print('Transaction sent! Hash: $response');
      trxResult = 'Transaction sent! Hash: $response';
      notifyListeners();
    } else {
      print('Failed to send transaction.');
    }
  }

  Future<Credentials> _getCredentials() async {
    String? privateKey = await LocalDataBase.getData("peky");
    String? privateKeys = privateKey;
    if (privateKeys != null) {
      return EthPrivateKey.fromHex(privateKey!);
    } else {
      throw Exception('Invalid private key.');
    }
  }
}
