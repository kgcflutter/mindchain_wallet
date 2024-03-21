import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/model/transaction_model.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:http/http.dart' as http;

class AccountDetailsProvider extends ChangeNotifier {
  AccountDetailsProvider() {
    loadPrivateKeyAddress();
  }

  String myPrivateKey = '';
  String myAddress = '';
  bool showKey = false;
  List<Transaction> transactionFulldata = []; // Specifying type for the list
  String trxResult = '';
  bool trxLoading = false;

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

  Future<void> fetchUserTransactionData() async {
    trxLoading = true;
    notifyListeners();
    transactionFulldata.clear();
    trxResult = '';
    String urls =
        'https://mainnet.mindscan.info/api/v2/addresses/${await LocalDataBase.getData("address")}/transactions';
    try {
      http.Response response = await http.get(
        Uri.parse(urls),
      );
      Map<String, dynamic> body = jsonDecode(response.body);
      if (body.keys.contains("message")) {
        trxResult = body['message'];
        trxLoading = false;
        notifyListeners();
      } else {
        List<dynamic> myData = body['items'];
        for (var element in myData) {
          transactionFulldata.add(Transaction.fromJson(element));
        }
        trxLoading = false;
        notifyListeners();
      }
    } catch (e) {
      trxLoading = false;
      trxResult = 'Failed to fetch transactions: $e';
    }
    notifyListeners();
  }
}
