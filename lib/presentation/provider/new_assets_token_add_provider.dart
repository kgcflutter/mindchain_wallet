import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mindchain_wallet/abiJson.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/privatekeyAuth.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class NewAssetsTokenAddProvider extends ChangeNotifier {
  final ethClient =
      Web3Client('https://seednode.mindchain.info/', http.Client());

  List allScreenTokenList = [];

  List tokens = [
    {
      "name": "MUSD",
      "balance": "0.0",
      "address": "0xaC264f337b2780b9fd277cd9C9B2149B43F87904",
      "show": true,
      "image": AssetsPath.musdPng
    },
    {
      "name": "PMIND",
      "balance": "0.0",
      "address": "0x75E218790B76654A5EdA1D0797B46cBC709136b0",
      "show": true,
      "image": AssetsPath.musdPng
    },
    {
      "name": "WMIND",
      "balance": "0.0",
      "address": "0x94E6F64f9a00bE3a7B353f55b303DC5eb0C9C396",
      "show": true,
      "image": AssetsPath.musdPng,
    }
  ];

  Future showAddedTokenAndBalance() async {
    Credentials credentials = await getCredentials();
    String? data = await LocalDataBase.getData("tokenList");
    if (data == null) {
      await LocalDataBase.saveData("tokenList", jsonEncode(tokens));
      allScreenTokenList.addAll(jsonDecode(data!));
      for (var i = 0; i < allScreenTokenList.length; i++) {
        EthereumAddress tokenContractAddress =
            EthereumAddress.fromHex(allScreenTokenList[i]['address']);
        DeployedContract contract = DeployedContract(
          ContractAbi.fromJson(abiJson, 'MINDChainUSD'),
          tokenContractAddress,
        );
        final contractFunction = contract.function('balanceOf');
        List<dynamic> result = await ethClient.call(
          contract: contract,
          function: contractFunction,
          params: [credentials.address],
        );
        BigInt tokenBalance = result[0] as BigInt;
        allScreenTokenList[i]['balance'] =
            totalPublicConvertToEth(tokenBalance);
        notifyListeners();
      }
    } else {
      allScreenTokenList.addAll(jsonDecode(data!));
      for (var i = 0; i < allScreenTokenList.length; i++) {
        EthereumAddress tokenContractAddress =
            EthereumAddress.fromHex(allScreenTokenList[i]['address']);
        DeployedContract contract = DeployedContract(
          ContractAbi.fromJson(abiJson, 'MINDChainUSD'),
          tokenContractAddress,
        );
        final contractFunction = contract.function('balanceOf');
        List<dynamic> result = await ethClient.call(
          contract: contract,
          function: contractFunction,
          params: [credentials.address],
        );
        BigInt tokenBalance = result[0] as BigInt;
        allScreenTokenList[i]['balance'] =
            totalPublicConvertToEth(tokenBalance);
        print(tokenBalance);
        notifyListeners();
      }
    }
  }

  enableDisableMaker(bool enable, int index) async {
    allScreenTokenList.clear();
    await LocalDataBase.removeDataByName("tokenList");
    tokens[index]['show'] = enable;
    await LocalDataBase.saveData("tokenList", jsonEncode(tokens));
    String? data = await LocalDataBase.getData("tokenList");
    allScreenTokenList.addAll(jsonDecode(data!));
    notifyListeners();
  }
}
