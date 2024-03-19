import 'package:flutter/cupertino.dart';
import 'package:mindchain_wallet/presentation/local_database.dart';

class AccountDetailsProvider extends ChangeNotifier {
  AccountDetailsProvider(){
    loadPrivateKeyAddress();
  }

  String myPrivateKey = '';
  String myAddress = '';
  bool showKey = false;

  loadPrivateKeyAddress() async {
   myPrivateKey = (await LocalDataBase.getData("pkey"))!;
   myAddress = (await LocalDataBase.getData("address"))!;
   notifyListeners();
  }

  void showMyKey() {
    showKey = !showKey;
    notifyListeners();
  }
}