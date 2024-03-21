import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mindchain_wallet/model/transaction_model.dart';
import 'package:mindchain_wallet/presentation/local_database.dart';
import 'package:http/http.dart' as http;

class AccountDetailsProvider extends ChangeNotifier {
  AccountDetailsProvider() {
    loadPrivateKeyAddress();
  }

  String myPrivateKey = '';
  String myAddress = '';
  bool showKey = false;
  List transactionFulldata = [];
  String trxResult = '';

  loadPrivateKeyAddress() async {
    String? myP = await LocalDataBase.getData("pkey");
    String myAdrs = (await LocalDataBase.getData("address"))!;
    if (myP != null) {
      myPrivateKey = myP;
      myAddress = myAdrs;
      notifyListeners();
    }
  }

  void showMyKey() {
    showKey = !showKey;
    notifyListeners();
  }

  Future fetchUserTransaction() async {
    transactionFulldata.clear();
    trxResult = '';
    String urls =
        'https://mainnet.mindscan.info/api/v2/addresses/$myAddress/transactions';
    http.Response response = await http.get(
      Uri.parse(urls),
    );
    Map body = jsonDecode(response.body);

    print(body);
    if(body['message'] == null){
      transactionFulldata = body['items'];
    }else{
      trxResult = await body['message'];
      notifyListeners();
    }
    notifyListeners();
  }

 Future<String> sendReceivedMaker(int index)async{
    if(myAddress == transactionFulldata[index]['to']['hash']){
      return 'Receive';
    }else{
      return 'send';
    }
  }

}
