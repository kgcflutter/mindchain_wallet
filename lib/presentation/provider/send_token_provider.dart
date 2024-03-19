import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import '../local_database.dart';

class SendTokenProvider extends ChangeNotifier {
  TextEditingController addressTEC = TextEditingController();
  TextEditingController amountTEC = TextEditingController();
  TextEditingController gesPriceTEC = TextEditingController();
  TextEditingController gesLimitTEC = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  final Web3Client ethClient;
  String trxResult = '';
  bool btnLoading = false;

  SendTokenProvider()
      : ethClient = Web3Client(
    'https://seednode.mindchain.info/',
    http.Client(),
  );

  Future<void> sendEth() async {
    trxResult = '';
    btnLoading = true;
    notifyListeners();
    String? recipientAddress = addressTEC.text;
    print('Enter the amount to send:');
    String? amount = amountTEC.text;
    if (recipientAddress != null && amount != null) {
      try {
        double parsedAmount = double.parse(amount);
        BigInt weiAmount = BigInt.from(parsedAmount * 1e18);
        EtherAmount ethAmount =
        EtherAmount.fromUnitAndValue(EtherUnit.wei, weiAmount);
        await _sendTransaction(ethClient, recipientAddress, ethAmount);
      } catch (e) {
        print('Invalid amount entered. Please enter a valid number.');
      }
    } else {
      print('Invalid recipient address or amount.');
    }
  }

  Future<void> _sendTransaction(Web3Client ethClient, String receiver,
      EtherAmount txValue) async {
    var chainId = await ethClient.getChainId();
    trxResult = 'Sending transaction...';
    notifyListeners();
    Credentials credentials = await _getCredentials();
    EtherAmount gasPrice = await ethClient.getGasPrice();
    BigInt gasEstimate = await ethClient.estimateGas(
      sender: credentials.address,
      to: EthereumAddress.fromHex(receiver),
      value: txValue,
    );
    Transaction transaction = Transaction(
      to: EthereumAddress.fromHex(receiver),
      gasPrice: gasPrice,
      maxGas: gasEstimate.toInt(), // You can adjust gas limit as needed
      value: txValue,
    );

    final response = await ethClient.sendTransaction(credentials, transaction,
        chainId: int.parse(chainId.toString()));

    if (response != null) {
      print('Transaction sent! Hash: $response');
      trxResult = 'Transaction sent! Hash: $response';
      if (response != null) {
        loadGesPrice();
        addressTEC.text = '';
        amountTEC.text = '';
        btnLoading = false;
      }
      notifyListeners();
    } else {
      print('Failed to send transaction.');
    }
  }

  Future<Credentials> _getCredentials() async {
    String? privateKey = await LocalDataBase.getData("pkey");
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
    gesLimitTEC.text = '21000';
    gesPriceTEC.text = gasPrice.getInWei.toString();
    notifyListeners();
  }


  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      print(result!.format.toString());
      // Update the address text field when a QR code is scanned
      if(result!.code != null){
        addressTEC.text = result?.code ?? '';
        notifyListeners();
      }
      notifyListeners();
    });
  }
}
