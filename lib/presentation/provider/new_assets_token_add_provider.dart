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

  List allTokens = [
    {"name": "MUSD", "contrct": "0xaC264f337b2780b9fd277cd9C9B2149B43F87904"},
  ];

  List enabledTokens = [];

  Future showAddedTokenAndBalance() async {
    Credentials credentials = await getCredentials();
    EthereumAddress tokenContractAddress = EthereumAddress.fromHex('0xaC264f337b2780b9fd277cd9C9B2149B43F87904');
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
    print(tokenBalance);
    notifyListeners();
  }

  String balanceMaker(String myBal, value) {
    double result = double.parse(value) * double.parse(myBal);
    return result.toString();
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
