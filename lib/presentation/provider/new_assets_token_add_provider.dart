import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/abiJson.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/privatekeyAuth.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class NewAssetsTokenAddProvider extends ChangeNotifier {
  final ethClient =
      Web3Client('https://seednode.mindchain.info/', http.Client());

  List allTokens = [
    {"name": "USDT", "image": AssetsPath.tetherUSDTPNG, "contract": "0x32a8a2052b48Da5FD253cC8B386B88B3E0BF50eE", "balance": '0.0'},
    {"name": "MUSD", "image": AssetsPath.musdPng, "contract": "0xaC264f337b2780b9fd277cd9C9B2149B43F87904", "balance": '0.0'},
    {"name": "PMIND", "image": AssetsPath.perrymindPng, "contract": "0x75E218790B76654A5EdA1D0797B46cBC709136b0", "balance": '0.0'},
    {"name": "WMIND", "image": AssetsPath.mindLogoPng, "contract": "0x94E6F64f9a00bE3a7B353f55b303DC5eb0C9C396", "balance": '0.0'},
  ];

  List enabledTokens = [];

  Future showAddedTokenAndBalance() async {
    enabledTokens.add({"name": "MIND", "image": AssetsPath.mindLogoPng, "contract": "null", "balance": '0.0'},);
    enabledTokens.add(allTokens[0]);
    enabledTokens.add(allTokens[1]);
    Credentials credentials = await getCredentials();
    for (int i = 0; i < allTokens.length; i++) {
      EthereumAddress tokenContractAddress =
          EthereumAddress.fromHex(allTokens[i]['contract']);
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
      notifyListeners();
    }
  }

  String balanceMaker(String myBal, value) {
    double result = double.parse(value) * double.parse(myBal);
    return result.toString();
  }

  void toggleToken(Map tokenKey) {
    if (enabledTokens.contains(tokenKey)) {
      enabledTokens.remove(tokenKey);
    } else {
      enabledTokens.add(tokenKey);
    }
    notifyListeners();
  }
}
