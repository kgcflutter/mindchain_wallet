import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mindchain_wallet/abiJson.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/privatekeyAuth.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class NewAssetsTokenAddProvider extends ChangeNotifier {
  final ethClient = Web3Client('https://seednode.mindchain.info/', http.Client());
  final Uri _mindRegisterURLS = Uri.parse('https://mindchain.info/Api/Index/marketinfo');

  String totalDollar = '\$0.0';
  String mindBalance = '0.0';

  List allTokens = [
    {
      "symbol": "musd_usdt",
      "name": "USDT",
      "image": AssetsPath.tetherUSDTPNG,
      "contract": "0x32a8a2052b48Da5FD253cC8B386B88B3E0BF50eE",
      "balance": "0.0",
      "dollar": "0.0",
      "change": '0',
      "total": 0.0
    },
    {
      "symbol": "musd_usdt",
      "name": "MUSD",
      "image": AssetsPath.musdPng,
      "contract": "0xaC264f337b2780b9fd277cd9C9B2149B43F87904",
      "balance": "0.0",
      "dollar": "0.0",
      "change": '0',
      "total": 0.0
    },
    {
      "symbol": "pmind_musd",
      "name": "PMIND",
      "image": AssetsPath.perrymindPng,
      "contract": "0x75E218790B76654A5EdA1D0797B46cBC709136b0",
      "balance": "0.0",
      "dollar": '0.0',
      "change": '0',
      "total": 0.0
    },
    {
      "name": "WMIND",
      "symbol": "wmind",
      "image": AssetsPath.mindLogoPng,
      "contract": "0x94E6F64f9a00bE3a7B353f55b303DC5eb0C9C396",
      "balance": "0.0",
      "dollar": "0.0",
      "change": '0',
      "total": 0.0
    },
  ];

  List enabledTokens = [];
  Timer? _marketDataTimer;

  Future showAddedTokenAndBalance() async {
    enabledTokens.clear();
    enabledTokens.add({
      "symbol": "mind_musd",
      "name": "MIND",
      "image": AssetsPath.mindLogoPng,
      "contract": "null",
      "balance": mindBalance,
      "dollar": 0.0,
      "change": '0',
      "total": 0.0
    });
    enabledTokens.add(allTokens[0]);
    enabledTokens.add(allTokens[1]);
    enabledTokens.add(allTokens[2]);
    enabledTokens.add(allTokens[3]);

    Credentials credentials = await getCredentials();
    for (int i = 0; i < allTokens.length; i++) {
      EthereumAddress tokenContractAddress = EthereumAddress.fromHex(allTokens[i]['contract']);
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abiJson, "MINDChainUSD"),
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

    await loadDollarValue(); // Load initial dollar values
    startMarketDataTimer(); // Start periodic updates
    notifyListeners();
  }

  Future loadDollarValue() async {
    http.Response response = await http.get(_mindRegisterURLS);
    if (response.statusCode == 200) {
      Map responseMap = jsonDecode(response.body);
      List responseList = responseMap['data']['market'];

      var marketDataMap = {for (var item in responseList) item['ticker']: item};

      for (var token in enabledTokens) {
        var ticker = token['symbol'];
        if (marketDataMap.containsKey(ticker)) {
          token['dollar'] = double.parse(marketDataMap[ticker]['new_price']).toStringAsFixed(2);
          token['change'] = marketDataMap[ticker]['change'].toString();
        }
      }
    } else {
      if (kDebugMode) {
        print("Error loading market data");
      }
    }
    calculateTotalDollar();
    notifyListeners();
  }

  void startMarketDataTimer() {
    _marketDataTimer?.cancel(); // Cancel existing timer if any
    _marketDataTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      loadDollarValue(); // Fetch market data every 10 seconds
    });
  }


  void calculateTotalDollar() {
    double total = 0.0;
    for (var token in enabledTokens) {
      var dollarValue = token['dollar'];
      if (dollarValue != null) {
        total += double.tryParse(dollarValue.toString()) ?? 0.0;
      }
    }
    totalDollar = '\$${total.toStringAsFixed(2)}'; // Format to 2 decimal places
    notifyListeners();
  }

  String balanceMaker(String myBal, value) {
    try {
      double parsedMyBal = double.parse(myBal);
      double parsedValue = double.parse(value.toString());
      double result = parsedValue * parsedMyBal;
      return "\$${result.toStringAsFixed(6)}";
    } catch (e) {
      return "\$0.0"; // Return a default value in case of an error
    }
  }

  void toggleToken(Map tokenKey) {
    if (enabledTokens.contains(tokenKey)) {
      enabledTokens.remove(tokenKey);
    } else {
      enabledTokens.add(tokenKey);
    }
    notifyListeners();
  }

  Future<void> connectWebSocketForLoadBalance(String url, String address) async {
    try {
      final socket = await WebSocket.connect(url);
      if (kDebugMode) {
        print('Connected to WebSocket server');
      }
      socket.done.then((_) async {
        await Future.delayed(const Duration(seconds: 5));
        await connectWebSocketForLoadBalance(url, address);// Reconnect
      });
      calculateTotalDollar();
      Stream.periodic(const Duration(seconds: 1)).listen((_) {
        final balanceSubscribePayload = json.encode({
          'id': 1,
          'method': 'eth_getBalance',
          'params': [address, 'latest'],
        });
        socket.add(balanceSubscribePayload);
      });

      socket.listen((message) {
        final data = json.decode(message);
        if (data['id'] == 1 && data['result'] != null) {
          final balanceHex = data['result'];
          final balanceInWei = BigInt.parse(balanceHex.substring(2), radix: 16);
          mindBalance = convertToEth(balanceInWei);
          enabledTokens[0]['balance'] = mindBalance; // Update MIND balance
          notifyListeners();

          // Update all token balances as needed
          updateTokenBalances();
        }
      }, onError: (_) {}, cancelOnError: true);
    } catch (_) {
      await Future.delayed(const Duration(seconds: 5));
      await connectWebSocketForLoadBalance(url, address); // Reconnect
    }
  }

  void updateTokenBalances() async {
    Credentials credentials = await getCredentials();
    for (int i = 0; i < allTokens.length; i++) {
      EthereumAddress tokenContractAddress = EthereumAddress.fromHex(allTokens[i]['contract']);
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abiJson, "MINDChainUSD"),
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

  Future loadBalances() async {
    var data = await LocalDataBase.getData("address");
    final address = EthereumAddress.fromHex(data!);
    await connectWebSocketForLoadBalance("wss://seednode.mindchain.info/ws", address.hex);
  }

  @override
  void dispose() {
    _marketDataTimer?.cancel();
    super.dispose();
  }
}
