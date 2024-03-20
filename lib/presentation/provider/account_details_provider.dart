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
    String? myP = await LocalDataBase.getData("pkey");
    String myAdrs = (await LocalDataBase.getData("address"))!;
    if(myP != null){
      myPrivateKey = myP;
      myAddress = myAdrs;
      notifyListeners();
    }
  }

  void showMyKey() {
    showKey = !showKey;
    notifyListeners();
  }
}