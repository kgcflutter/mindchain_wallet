import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mindchain_wallet/abiJson.dart';
import 'package:mindchain_wallet/model/token_model.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/privatekeyAuth.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class NewAssetsTokenAddProvider extends ChangeNotifier {
  final ethClient =
      Web3Client('https://seednode.mindchain.info/', http.Client());

  List allScreenTokenList = [];

  List tokens = [
    {
      "id": "24",
      "name": "USDT",
      "balance": "0.0",
      "address": "0x32a8a2052b48Da5FD253cC8B386B88B3E0BF50eE",
      "show": true,
      "image": AssetsPath.tetherUSDTPNG,
      "value":  "\$0.0"
    },
    {
      "id": "24",
      "name": "MUSD",
      "balance": "0.0",
      "address": "0xaC264f337b2780b9fd277cd9C9B2149B43F87904",
      "show": true,
      "image": AssetsPath.musdPng,
      "value":  "\$0.0"
    },
    {
      "id": "31",
      "name": "PMIND",
      "balance": "0.0",
      "address": "0x75E218790B76654A5EdA1D0797B46cBC709136b0",
      "show": true,
      "image": AssetsPath.perrymindPng,
      "value":  "\$0.0"
    },
    {
      "id": "21",
      "name": "WMIND",
      "balance": "0.0",
      "address": "0x94E6F64f9a00bE3a7B353f55b303DC5eb0C9C396",
      "show": true,
      "image": AssetsPath.mindPng,
      "value":  "\$0.0",
    },
  ];



  Future showAddedTokenAndBalance() async {
    Credentials credentials = await getCredentials();
    allScreenTokenList.clear();
    for (var i = 0; i < tokens.length; i++) {
      EthereumAddress tokenContractAddress =
      EthereumAddress.fromHex(tokens[i]['address']);
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
      tokens[i]['balance'] =
          totalPublicConvertToEth(tokenBalance);
      allScreenTokenList.add(tokens[i]);
      notifyListeners();
    }

    http.Response res = await http.get(Uri.parse('https://mindchain.info/Api/Index/marketinfo'));
    var data = jsonDecode(res.body);

    allScreenTokenList[0]['value'] =
    "${double.parse(data['data']['market'][3]['new_price']).toStringAsFixed(2)}";
    allScreenTokenList[1]['value'] =
    "${double.parse(data['data']['market'][3]['new_price']).toStringAsFixed(2)}";
    allScreenTokenList[2]['value'] =
    "${double.parse(data['data']['market'][4]['new_price']).toStringAsFixed(2)}";
    allScreenTokenList[3]['value'] =
    "${double.parse(data['data']['market'][1]['new_price']).toStringAsFixed(2)}";
    notifyListeners();
  }

  enableDisableMaker(bool enable, int index) async {
    tokens[index]['show'] = enable;
    notifyListeners();
  }


 String balanceMaker(String mybal, value){
    double result = double.parse(value)*double.parse(mybal);
    return result.toString();
  }

}
