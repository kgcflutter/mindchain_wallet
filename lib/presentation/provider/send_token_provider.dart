import 'package:flutter/cupertino.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import '../local_database.dart';

class SendTokenProvider extends ChangeNotifier {

  TextEditingController addressTEC = TextEditingController();
  TextEditingController amountTEC = TextEditingController();
  TextEditingController gesPriceTEC = TextEditingController();
  TextEditingController gesLimitTEC = TextEditingController();

  final Web3Client ethClient;
  String trxResult = '';

  SendTokenProvider()
      : ethClient = Web3Client(
          'https://seednode.mindchain.info/',
          http.Client(),
        );

  Future<void> sendEth() async {
    String? recipientAddress = addressTEC.text;
    print('Enter the amount to send:');
    String? amount = amountTEC.text;
    if (recipientAddress != null && amount != null) {
      print(amount);
      try {
        // Parse the amount as double
        double parsedAmount = double.parse(amount);

        // Convert the amount to wei (the smallest unit of Ether) by multiplying it with 10^18
        BigInt weiAmount = BigInt.from(parsedAmount * 1e18);

        // Convert the wei amount to EtherAmount
        EtherAmount ethAmount = EtherAmount.fromUnitAndValue(EtherUnit.wei, weiAmount);

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
      maxGas: int.parse(gesLimitTEC.text), // You can adjust gas limit as needed
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
    String? privateKey = await LocalDataBase.getData("pkey");
    print("pkey $privateKey");
    String? privateKeys = privateKey;
    if (privateKeys != null) {
      return EthPrivateKey.fromHex(privateKey!);
    } else {
      throw Exception('Invalid private key.');
    }
  }

  loadGesPrice() async {
    EtherAmount gasPrice = await ethClient.getGasPrice();
    gesPriceTEC.text = '';
    gesLimitTEC.text = '';
    gesPriceTEC.text = gasPrice.getInWei.toString();
    gesLimitTEC.text = "21000";
    notifyListeners();
  }
}
