import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import '../../authenticator/privatekeyAuth.dart';
import '../utils/local_database.dart';

class Token {
  String name;
  String symbol;
  String contractAddress;
  int decimals;
  String abi;

  Token(this.name, this.symbol, this.contractAddress, this.decimals, this.abi);
}

class SendTokenProvider extends ChangeNotifier {
  TextEditingController addressTEC = TextEditingController();
  TextEditingController amountTEC = TextEditingController();
  TextEditingController gesPriceTEC = TextEditingController();
  TextEditingController gesLimitTEC = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool hideOpen = false;
  String address = '';
  String trxError = '';
  String trxWaiting = '';
  List<Token> tokens = [];

  final Web3Client ethClient;
  String trxResult = '';
  bool btnLoading = false;

  SendTokenProvider()
      : ethClient = Web3Client(
          'https://seednode.mindchain.info/',
          http.Client(),
        );

  tokenSwitcher(bool value, int index) {
    notifyListeners();
  }

  loadMyAddress() async {
    address = (await LocalDataBase.getData("address"))!;
    notifyListeners();
  }

  Future<void> sendEth() async {
    trxResult = '';
    trxError = '';
    trxWaiting = '';
    btnLoading = true;
    trxWaiting = "sending precess start";
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
        trxError = "Something Error Please Try again";
        notifyListeners();
        print('Invalid amount entered. Please enter a valid number.');
      }
    } else {
      trxError = 'Invalid recipient address or amount.';
      notifyListeners();
      print('Invalid recipient address or amount.');
    }
  }

  Future<void> _sendTransaction(
      Web3Client ethClient, String receiver, EtherAmount txValue) async {
    var chainId = await ethClient.getChainId();
    print('Sending transaction...');
    trxWaiting = 'Sending transaction...';
    notifyListeners();
    Credentials credentials = await getCredentials();
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
      trxWaiting = "Done Your Transaction sent! ";
      trxResult = response;
      notifyListeners();
      if (response != null) {
        loadGesPrice();
        btnLoading = false;
      }
      notifyListeners();
    } else {
      print('Failed to send transaction.');
    }
  }

  loadGesPrice() async {
    EtherAmount gasPrice = await ethClient.getGasPrice();
    gesPriceTEC.text = '';
    gesLimitTEC.text = '21000';
    gesPriceTEC.text = (gasPrice.getInWei / BigInt.from(1000000000)).toString();
    notifyListeners();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      print(result!.format.toString());
      // Update the address text field when a QR code is scanned
      if (result!.code != null) {
        addressTEC.text = result?.code ?? '';
        notifyListeners();
      }
      notifyListeners();
    });
  }

  hideOpenInput(String value) {
    if (value != null && value.isNotEmpty) {
      hideOpen = true;
      print(hideOpen);
      notifyListeners();
    } else {
      hideOpen = false;
      print(hideOpen);
      notifyListeners();
    }
  }

  Future<void> addNewToken(String contractAddress) async {
    tokens.clear();
    if (contractAddress != null) {
      try {
        Token token = await _fetchTokenInfo(ethClient, contractAddress);
        tokens.add(token);
        print('Token added successfully: ${token.name} (${token.symbol})');
        notifyListeners();
      } catch (e) {
        print('Error adding token: $e');
      }
    } else {
      print('Invalid contract address.');
    }
  }

  Future<Token> _fetchTokenInfo(
      Web3Client ethClient, String contractAddress) async {
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
    return Token(name[0] as String, symbol[0] as String, contractAddress,
        decimals, tokenAbi);
  }

  Future<void> sendTokenTransactionOption() async {
    trxResult = '';
    trxError = '';
    trxWaiting = '';
    btnLoading = true;
    trxWaiting = "sending precess start";
    notifyListeners();
    if (addressTEC.text != null && amountTEC.text != null) {
      try {
        double parsedAmount = double.parse(amountTEC.text);
        BigInt weiAmount = BigInt.from(parsedAmount * 1e18);
        BigInt newparsedAmount = BigInt.parse(weiAmount.toString());
        // Assuming you have selected a token from your list of added tokens
        Token selectedToken = tokens
            .first; // You might want to add logic to select a token from the list
        await sendTokenTransaction(
            ethClient, selectedToken, addressTEC.text, newparsedAmount);
      } catch (e) {
        print('Invalid amount entered. Please enter a valid number.');
        trxError = 'Invalid amount entered. Please enter a valid number.';
        notifyListeners();
      }
    } else {
      print('Invalid recipient address or amount.');
      trxError = 'Invalid recipient address or amount.';
      notifyListeners();
    }
  }

  Future<void> sendTokenTransaction(
      Web3Client ethClient, Token token, String receiver, BigInt amount) async {
    var chainId = await ethClient.getChainId();
    trxWaiting = "Sending token transaction...";
    notifyListeners();
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
      trxResult = response.toString();
      notifyListeners();
    } else {
      print('Failed to send token transaction.');
      trxError = 'Failed to send token transaction.';
      notifyListeners();
    }
  }

  String bytesToHex(List<int> bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

// Replace this with actual ABI of ERC20 token
  static const String tokenAbi =
      '[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"}]';
}
