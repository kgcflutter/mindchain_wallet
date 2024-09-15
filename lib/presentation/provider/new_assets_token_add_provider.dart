import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/allTokenList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mindchain_wallet/abiJson.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/privatekeyAuth.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class NewAssetsTokenAddProvider extends ChangeNotifier {
  final ethClient = Web3Client('https://seednode.mindchain.info/', http.Client());

  String totalDollar = '\$0.0';
  String mindBalance = '0.0';

  List<Map<String, dynamic>> allTokens = myTokens;
  List<Map<String, dynamic>> enabledTokens = [];
  List<Map<String, dynamic>> filteredTokens = [];
  Timer? _marketDataTimer;

  NewAssetsTokenAddProvider() {
    filteredTokens = List.from(allTokens);
    loadAssetsFromSharedPreferences();
  }

  Future<void> saveAssetsToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tokens = allTokens.map((token) => jsonEncode(token)).toList();
    await prefs.setStringList('savedAssets', tokens);
  }

  Future<void> loadAssetsFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tokens = prefs.getStringList('savedAssets');
    if (tokens != null) {
      allTokens = tokens.map((token) => jsonDecode(token) as Map<String, dynamic>).toList();
      filteredTokens = List.from(allTokens);
    }
    notifyListeners();
  }

  Future<void> addNewAsset(String contractAddress, BuildContext context) async {
    final isValid = await validateContractAddress(contractAddress);
    if (!isValid) {
      throw Exception('Invalid contract address');
    }

    final isAlreadyAdded = allTokens.any((token) => token['contract'] == contractAddress);
    if (isAlreadyAdded) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The token is already added")));
      return;
    }

    try {
      EthereumAddress tokenContractAddress = EthereumAddress.fromHex(contractAddress);
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abiJson, "ERC20"),
        tokenContractAddress,
      );

      final nameFunction = contract.function('name');
      final symbolFunction = contract.function('symbol');

      final nameResult = await ethClient.call(
        contract: contract,
        function: nameFunction,
        params: [],
      );

      final symbolResult = await ethClient.call(
        contract: contract,
        function: symbolFunction,
        params: [],
      );

      final tokenName = nameResult[0] as String;
      final tokenSymbol = symbolResult[0] as String;

      allTokens.add({
        'name': tokenName,
        'symbol': tokenSymbol,
        'contract': contractAddress,
        'image': 'assets/placeholder.png',
        'balance': '0.0',
        'dollar': '0.0',
        'change': '0',
        'total': 0.0,
      });

      filteredTokens = List.from(allTokens);
      await saveAssetsToSharedPreferences();
      updateTokenBalances();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error adding new asset: $e');
      }
      rethrow;
    }
  }

  Future<bool> validateContractAddress(String contractAddress) async {
    try {
      EthereumAddress address = EthereumAddress.fromHex(contractAddress);
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abiJson, "ERC20"),
        address,
      );
      final nameFunction = contract.function('name');
      await ethClient.call(
        contract: contract,
        function: nameFunction,
        params: [],
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Invalid contract address: $e');
      }
      return false;
    }
  }

  void searchTokens(String query) {
    if (query.isEmpty) {
      filteredTokens = List.from(allTokens);
    } else {
      filteredTokens = allTokens.where((token) {
        final nameLower = token['name'].toLowerCase();
        final symbolLower = token['symbol'].toLowerCase();
        final searchLower = query.toLowerCase();
        return nameLower.contains(searchLower) || symbolLower.contains(searchLower);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> showAddedTokenAndBalance() async {
    enabledTokens.clear();
    enabledTokens.add({
      "symbol": "MIND",
      "name": "MIND",
      "image": AssetsPath.mindLogoPng,
      "contract": "null",
      "balance": mindBalance,
      "dollar": '0.0',
      "change": '0',
      "total": 0.0
    });
    enabledTokens.addAll(allTokens);

    Credentials credentials = await getCredentials();
    for (int i = 0; i < allTokens.length; i++) {
      EthereumAddress tokenContractAddress = EthereumAddress.fromHex(allTokens[i]['contract']);
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abiJson, "ERC20"),
        tokenContractAddress,
      );
      final contractFunction = contract.function('balanceOf');
      List<dynamic> result = await ethClient.call(
        contract: contract,
        function: contractFunction,
        params: [credentials.address],
      );
      BigInt tokenBalance = result[0] as BigInt;
      allTokens[i]['balance'] = totalPublicConvertToEth(tokenBalance);
    }
    startMarketDataTimer();
    notifyListeners();
  }

  void startMarketDataTimer() {
    _marketDataTimer?.cancel();
    _marketDataTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      //loadDollarValue();
    });
  }

  void calculateTotalDollar() {
    double total = 0.0;
    for (var token in enabledTokens) {
      var dollarValue = token['dollar'];
      total += double.parse(mindBalance) * double.parse(dollarValue.toString());
    }
    totalDollar = '\$${total.toStringAsFixed(2)}';
    notifyListeners();
  }

  String balanceMaker(String myBal, value) {
    try {
      double parsedMyBal = double.parse(myBal);
      double parsedValue = double.parse(value.toString());
      double result = parsedValue * parsedMyBal;
      return "\$${result.toStringAsFixed(3)}";
    } catch (e) {
      return "\$0.0";
    }
  }

  void toggleToken(Map<String, dynamic> tokenKey) {
    if (enabledTokens.contains(tokenKey)) {
      enabledTokens.remove(tokenKey);
    } else {
      enabledTokens.add(tokenKey);
    }
    notifyListeners();
  }

  Future<void> loadBalances() async {
    var data = await LocalDataBase.getData("address");
    final address = EthereumAddress.fromHex(data!);

    // Use direct RPC call to get balance
    await getBalanceFromRPC(address.hex);
  }

  Future<void> getBalanceFromRPC(String address) async {
    final balanceResult = await ethClient.getBalance(EthereumAddress.fromHex(address));
    mindBalance = convertToEth(balanceResult.getInWei);

    if (enabledTokens.isNotEmpty) {
      enabledTokens[0]['balance'] = mindBalance;  // Safely updating balance if list is not empty
    }

    updateTokenBalances();
    notifyListeners();
  }


  void updateTokenBalances() async {
    Credentials credentials = await getCredentials();
    for (int i = 0; i < allTokens.length; i++) {
      EthereumAddress tokenContractAddress = EthereumAddress.fromHex(allTokens[i]['contract']);
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abiJson, "ERC20"),
        tokenContractAddress,
      );
      final contractFunction = contract.function('balanceOf');
      List<dynamic> result = await ethClient.call(
        contract: contract,
        function: contractFunction,
        params: [credentials.address],
      );
      BigInt tokenBalance = result[0] as BigInt;
      allTokens[i]['balance'] = totalPublicConvertToEth(tokenBalance);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _marketDataTimer?.cancel();
    super.dispose();
  }
}
