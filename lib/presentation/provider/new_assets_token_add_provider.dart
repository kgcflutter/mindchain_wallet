import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/abiJson.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/privatekeyAuth.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class NewAssetsTokenAddProvider extends ChangeNotifier {
  final ethClient =
      Web3Client('https://seednode.mindchain.info/', http.Client());


  Map<String, dynamic> allTokens = {};
  List<String> enabledTokens = [];

  Future showAddedTokenAndBalance() async {
    Credentials credentials = await getCredentials();
    for (var a = 0; a < allTokens.length; a++) {
      EthereumAddress tokenContractAddress = EthereumAddress.fromHex('address');
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abiJson, ""),
        tokenContractAddress,
      );
      final contractFunction = contract.function('balanceOf');
      List<dynamic> result = await ethClient.call(
        contract: contract,
        function: contractFunction,
        params: [credentials.address],
      );
      BigInt tokenBalance = result[0] as BigInt;
    }

    notifyListeners();
  }

  String balanceMaker(String myBal, value) {
    double result = double.parse(value) * double.parse(myBal);
    return result.toString();
  }

  Future<void> fetchTokens() async {
    if (allTokens.isEmpty) {
      allTokens.clear();
      final response = await http.get(
        Uri.parse("https://msc-token-registry.vercel.app"),
      );
      if (response.statusCode == 200) {
        allTokens = json.decode(response.body)['data'];
        print(allTokens);
        if(allTokens.length >3){
          enabledTokens.add(allTokens.keys.elementAt(0));
          enabledTokens.add(allTokens.keys.elementAt(1));
          enabledTokens.add(allTokens.keys.elementAt(2));
        }
        notifyListeners();
      } else {
        throw Exception('Failed to load tokens');
      }
    }
  }

  void toggleToken(String tokenKey) {
    if (enabledTokens.contains(tokenKey)) {
      enabledTokens.remove(tokenKey);
    } else {
      enabledTokens.add(tokenKey);
    }
    notifyListeners();
  }
}
